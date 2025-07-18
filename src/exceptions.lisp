;; (defpackage #:utopian-r/exceptions
;;   (:use #:cl)
;;   (:export #:http-exception
;;            #:http-redirect
;;            #:http-exception-code
;;            #:http-redirect-to
;;            #:http-redirect-code
;;            #:throw-code
;;            #:redirect-to))
(in-package #:utopian-r)

(defparameter *http-status*
  (loop with status = (make-hash-table :test #'eql)
        for (code . reason) in '((100 . "Continue")
                                 (101 . "Switching Protocols")
                                 (200 . "OK")
                                 (201 . "Created")
                                 (202 . "Accepted")
                                 (203 . "Non-Authoritative Information")
                                 (204 . "No Content")
                                 (205 . "Reset Content")
                                 (206 . "Partial Content")
                                 (207 . "Multi-Status")
                                 (300 . "Multiple Choices")
                                 (301 . "Moved Permanently")
                                 (302 . "Moved Temporarily")
                                 (303 . "See Other")
                                 (304 . "Not Modified")
                                 (305 . "Use Proxy")
                                 (307 . "Temporary Redirect")
                                 (400 . "Bad Request")
                                 (401 . "Authorization Required")
                                 (402 . "Payment Required")
                                 (403 . "Forbidden")
                                 (404 . "Not Found")
                                 (405 . "Method Not Allowed")
                                 (406 . "Not Acceptable")
                                 (407 . "Proxy Authentication Required")
                                 (408 . "Request Time-out")
                                 (409 . "Conflict")
                                 (410 . "Gone")
                                 (411 . "Length Required")
                                 (412 . "Precondition Failed")
                                 (413 . "Request Entity Too Large")
                                 (414 . "Request-URI Too Large")
                                 (415 . "Unsupported Media Type")
                                 (416 . "Requested range not satisfiable")
                                 (417 . "Expectation Failed")
                                 (424 . "Failed Dependency")
                                 (500 . "Internal Server Error")
                                 (501 . "Not Implemented")
                                 (502 . "Bad Gateway")
                                 (503 . "Service Unavailable")
                                 (504 . "Gateway Time-out")
                                 (505 . "Version not supported"))
        do (setf (gethash code status) reason)
        finally (return status)))

(defun http-status-reason (code)
  (gethash code *http-status*))

(define-condition http-exception (error)
  ((code :initarg :code
         :reader http-exception-code))
  (:report
   (lambda (condition stream)
     (with-slots (code) condition
       (format stream
               "~D~@[ ~A~]"
               code
               (http-status-reason code))))))

(define-condition http-redirect ()
  ((to :initarg :to
       :reader http-redirect-to)
   (code :initarg :code
         :initform 302
         :reader http-redirect-code)))

(defun throw-code (code)
  (error 'http-exception :code code))

(defun redirect-to (url &optional (code 302))
  (error 'http-redirect :to url :code code))
