(defpackage #:utopian-r/cli/generate
  (:use #:cl)
  (:import-from #:utopian-r/tasks/db
                #:generate-migrations)
  (:import-from #:utopian-r/errors
                #:invalid-arguments
                #:unknown-command
                #:file-not-found))
(in-package #:utopian-r/cli/generate)

(defun print-usage ()
  (format *error-output* "~&Usage: utopian-r generate COMMAND
COMMANDS
    migration
        Generate a migration file.
"))

(defun main (&optional command)
  (unless command
    (print-usage)
    (error 'invalid-arguments))
  (let ((app-file #P"app.lisp"))
    (unless (probe-file app-file)
      (error 'file-not-found :file app-file))
    (cond
      ((equal command "migration")
       (utopian-r/tasks/db:generate-migrations app-file))
      (t
       (error 'unknown-command
              :given command
              :candidates '("migration"))))))
