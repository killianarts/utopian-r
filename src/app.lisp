;; (defpackage #:utopian-r/app
;;   (:use #:cl)
;;   (:import-from #:utopian-r/routes
;;                 #:routes-mapper)
;;   (:import-from #:utopian-r/config
;;                 #:*config-dir*
;;                 #:config)
;;   (:import-from #:utopian-r/context
;;                 #:*request*
;;                 #:*response*)
;;   (:import-from #:utopian-r/exceptions
;;                 #:throw-code
;;                 #:http-exception
;;                 #:http-exception-code
;;                 #:http-redirect
;;                 #:http-redirect-to
;;                 #:http-redirect-code)
;;   (:import-from #:utopian-r/file-loader
;;                 #:load-file)
;;   (:import-from #:lack
;;                 #:builder)
;;   (:import-from #:lack.component
;;                 #:lack-component
;;                 #:to-app
;;                 #:call)
;;   (:import-from #:lack.response
;;                 #:response-body
;;                 #:response-headers
;;                 #:response-status
;;                 #:finalize-response)
;;   (:import-from #:lack.request)
;;   (:import-from #:myway)
;;   (:import-from #:safety-params
;;                 #:validation-error)
;;   (:import-from #:closer-mop)
;;   (:import-from #:alexandria
;;                 #:hash-table-plist)
;;   (:export #:application
;;            #:defapp
;;            #:with-config
;;            #:make-request
;;            #:make-response
;;            #:on-exception
;;            #:on-validation-error))
(in-package #:utopian-r)

(defclass application (lack.component:lack-component)
  ((routes :initarg :routes
           :accessor application-routes)
   (models :initarg :models
           :initform nil
           :accessor application-models)))

(defmacro with-config ((app) &body body)
  `(let ((*config-dir* (slot-value (class-of ,app) 'config)))
     ,@body))

(defmethod lack.component:to-app :around ((app application))
  (let* ((config-dir (slot-value (class-of app) 'config))
         (*config-dir* config-dir))
    (lack:builder
     (lambda (app)
       (lambda (env)
         (let ((*config-dir* config-dir))
           (funcall app env))))
     (call-next-method))))

(defmethod lack.component:call ((app application) env)
  (multiple-value-bind (res foundp)
      (myway:dispatch (routes-mapper (slot-value app 'routes))
                      (getf env :path-info)
                      :method (getf env :request-method))
    (if foundp
        (progn
          (setf (lack.response:response-body *response*) res)
          (lack.response:finalize-response *response*))
        (throw-code 404))))

(defmethod lack.component:call :around ((app application) env)
  (let ((*request*
          ;; Handle errors mainly while parsing an HTTP request
          ;;   for preventing from 500 ISE.
          (handler-case (make-request app env)
            (error (e)
              (warn "~A" e)
              (return-from lack.component:call '(400 () ("Bad Request"))))))
        (*response* (make-response app 200)))
    (handler-case (call-next-method)
      (http-exception (e)
        (setf (lack.response:response-status *response*)
              (http-exception-code e))
        (setf (lack.response:response-body *response*)
              (or (on-exception app e)
                  (princ-to-string e)))
        (lack.response:finalize-response *response*))
      (safety-params:validation-error (e)
        (setf (lack.response:response-status *response*) 400)
        (setf (lack.response:response-body *response*)
              (or (on-validation-error app e)
                  "Invalid parameters")))
      (http-redirect (c)
        (let ((to (http-redirect-to c))
              (code (http-redirect-code c)))
          (setf (getf (lack.response:response-headers *response*) :location) to)
          (setf (lack.response:response-status *response*) code)
          (setf (lack.response:response-body *response*) to))
        (lack.response:finalize-response *response*)))))

(defun load-models (app)
  (let ((models (application-models app)))
    (when models
      (labels ((directory-models (dir)
                 (append
                  (uiop:directory-files dir "*.lisp")
                  (mapcan #'directory-models (uiop:subdirectories dir)))))
        (let ((model-files (directory-models models)))
          (when model-files
            (let ((count (length model-files)))
              (format t "~&Loading model files (0/~A)" count)
              (loop for i from 0
                    for model-file in model-files
                    do (format t "~CLoading model files (~A/~A)"
                               #\Return
                               i
                               count)
                       (load-file model-file t))
              (format t "~CLoading model files...Done    ~%" #\Return))))))))

(defmethod to-app :before ((app application))
  (load-models app))

(defvar *default-headers*
  '(:x-content-type-options "nosniff"
    :x-frame-options "DENY"
    :cache-control "private"))

(defgeneric make-request (app env)
  (:method (app env)
    (declare (ignore app))
    (lack.request:make-request env)))

(defgeneric make-response (app &optional status headers body)
  (:method (app &optional status headers body)
    (let* ((app-class (class-of app))
           (default-content-type (first (slot-value app-class 'content-type)))
           (additional-headers (slot-value app-class 'additional-headers))
           (headers
             (append *default-headers*
                     (and default-content-type
                          (list :content-type default-content-type))
                     additional-headers
                     headers))
           (headers
             (loop with headers-map = (make-hash-table :test 'equal)
                   for (k v) on headers by #'cddr
                   if v
                     do (setf (gethash k headers-map)
                              (if (gethash k headers-map)
                                  (format nil "~A, ~A" (gethash k headers-map) v)
                                  v))
                   else
                     do (remhash k headers-map)
                   finally (return (alexandria:hash-table-plist headers-map)))))
      (lack.response:make-response status headers body))))

(defgeneric on-exception (app exception)
  (:method ((app application) (exception http-exception))
    nil))

(defgeneric on-validation-error (app error)
  (:method ((app application) (error error))
    nil))

(defclass utopian-r-app-class (standard-class)
  ((base-directory :initarg :base-directory
                   :initform *default-pathname-defaults*)
   (config :initarg :config
           :initform nil)
   (content-type :initarg :content-type
                 :initform '("text/html; charset=utf-8"))
   (additional-headers :initarg :additional-headers
                       :initform '())))

(defmethod initialize-instance :after ((class utopian-r-app-class) &rest initargs &key config &allow-other-keys)
  (declare (ignore initargs))
  (assert (and (listp config)
               (null (rest config))))
  (with-slots (base-directory config) class
    (when config
      (setf config
            (merge-pathnames (first config) (first base-directory))))))

(defmethod reinitialize-instance :after ((class utopian-r-app-class) &rest initargs &key config &allow-other-keys)
  (declare (ignore initargs))
  (assert (and (listp config)
               (null (rest config))))
  (with-slots (base-directory config) class
    (when config
      (setf config
            (merge-pathnames (first config) (first base-directory))))))

(defmethod c2mop:validate-superclass ((class utopian-r-app-class) (super standard-class))
  t)

(defmacro defapp (name superclasses slots &rest options)
  `(defclass ,name (application ,@superclasses)
     ,slots
     (:metaclass utopian-r-app-class)
     (:base-directory ,(uiop:pathname-directory-pathname (or *compile-file-pathname* *load-pathname*)))
     ,@options))
