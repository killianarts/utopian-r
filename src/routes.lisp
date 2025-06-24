;; (defpackage #:utopian-r/routes
;;   (:use #:cl)
;;   (:import-from #:utopian-r/context
;;                 #:*request*
;;                 #:*response*)
;;   (:import-from #:utopian-r/file-loader
;;                 #:intern-rule)
;;   (:import-from #:myway
;;                 #:make-mapper
;;                 #:connect
;;                 #:next-route)
;;   (:import-from #:lack.request
;;                 #:request-parameters)
;;   (:export #:defroutes
;;            #:routes
;;            #:routes-mapper
;;            #:routes-controllers-directory
;;            #:route

;;            ;; from MyWay
;;            #:next-route))
(in-package #:utopian-r)

(defvar *controllers-directory*)

(defun make-controller (action)
  (lambda (params)
    (funcall action
             (append (loop for (k v) on params by #'cddr
                           collect (cons k v))
                     (lack.request:request-parameters *request*)))))

(defun parse-controller-rule (rule)
  (etypecase rule
    ((or function symbol) (make-controller rule))
    (string
     (let ((action (intern-rule rule *controllers-directory*)))
       (assert (symbolp action))
       (make-controller action)))))

(defvar *package-routes* (make-hash-table :test 'eq))

(defclass routes ()
  ((controllers :initarg :controllers
                :reader routes-controllers-directory)
   (mapper :initarg :mapper
           :reader routes-mapper)))

(defmacro defroutes (name routing-rules &rest options)
  (let ((controllers-directory
          (uiop:pathname-directory-pathname (or *compile-file-pathname* *load-pathname*))))
    (loop for option in options
          do (ecase (first option)
               (:controllers
                (destructuring-bind (directory) (rest option)
                  (setf controllers-directory
                        (uiop:ensure-directory-pathname
                         (merge-pathnames directory controllers-directory)))))))
    `(progn
       (defvar ,name (make-instance 'routes
                                    :controllers ,controllers-directory
                                    :mapper (myway:make-mapper)))
       (setf (slot-value ,name 'mapper) (myway:make-mapper))
       (setf (package-routes) ,name)
       ,@(loop for rule in routing-rules
               collect `(route ,@rule))
       ,name)))

(defun package-routes (&optional (package *package*))
  (gethash package *package-routes*))

(defun (setf package-routes) (routes &optional (package *package*))
  (setf (gethash package *package-routes*) routes))

(defun route (method routing-rule controller)
  (let ((routes (package-routes)))
    (unless routes
      (error "No routes defined in this package."))
    (myway:connect (routes-mapper routes)
                   routing-rule
                   ;; TODO: load controller lazily
                   (let ((*controllers-directory* (routes-controllers-directory routes)))
                     (parse-controller-rule controller))
                   :method method)))
