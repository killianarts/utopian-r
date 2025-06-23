(defpackage #:utopian-r/cli/new
  (:use #:cl)
  (:import-from #:utopian-r/errors
                #:invalid-arguments)
  (:import-from #:utopian-r/tasks
                #:new
                #:ask-for-value
                #:use-value)
  (:export #:main))
(in-package #:utopian-r/cli/new)

(defun print-usage ()
  (format *error-output* "~&Usage: utopian-r new DESTINATION~%"))

(defun main (&optional destination)
  (unless destination
    (print-usage)
    (error 'invalid-arguments))
  (handler-bind ((ask-for-value
                   (lambda (e)
                     (let ((restart (find-restart 'use-value)))
                       (when restart
                         (invoke-restart-interactively restart))))))
    (format t "~&New project is created at '~A'.~%"
            (new destination))))
