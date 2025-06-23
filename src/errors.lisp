(defpackage #:utopian-r/errors
  (:use #:cl)
  (:export #:utopian-r-error
           #:utopian-r-task-error
           #:simple-task-error
           #:invalid-arguments
           #:unknown-command
           #:file-not-found
           #:system-not-found
           #:directory-already-exists))
(in-package #:utopian-r/errors)

(define-condition utopian-r-error (error) ())

(define-condition utopian-r-task-error (utopian-r-error) ())

(define-condition simple-task-error (utopian-r-task-error simple-error) ())

(define-condition invalid-arguments (utopian-r-task-error) ())

(define-condition unknown-command (utopian-r-task-error)
  ((given :initarg :given)
   (candidates :initarg :candidates
               :initform nil))
  (:report (lambda (condition stream)
             (with-slots (given candidates) condition
               (format stream "~&Command not found: ~A~%~@[Must be one of [ ~{~A~^ | ~} ]~]" given candidates)))))

(define-condition file-not-found (utopian-r-task-error)
  ((file :initarg file))
  (:report (lambda (condition stream)
             (with-slots (file) condition
               (format stream "File '~A' not found" file)))))

(define-condition system-not-found (utopian-r-task-error)
  ((system :initarg :system))
  (:report (lambda (condition stream)
             (with-slots (system) condition
               (format stream "System '~A' cannot be located.~%Make sure it's loadable by ASDF."
                       system)))))

(define-condition directory-already-exists (utopian-r-task-error)
  ((directory :initarg :directory))
  (:report (lambda (condition stream)
             (with-slots (directory) condition
               (format stream "Directory '~A' already exists." directory)))))
