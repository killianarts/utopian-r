(defpackage #:utopian-r/cli/db
  (:use #:cl)
  (:import-from #:utopian-r/errors
                #:invalid-arguments
                #:unknown-command
                #:file-not-found)
  (:import-from #:utopian-r/tasks/db)
  (:export #:main))
(in-package #:utopian-r/cli/db)

(defun print-usage ()
  (format *error-output* "~&Usage: utopian-r db COMMAND
COMMANDS
    create
        Create a database

    recreate
        Drop and create a new database

    migrate
        Apply migrations.

    migrate:status
        See the status of the database schema version.
"))

(defun main (&optional command)
  (unless command
    (print-usage)
    (error 'invalid-arguments))
  (let ((app-file #P"app.lisp"))
    (unless (probe-file app-file)
      (error 'file-not-found :file app-file))
    (cond
      ((equal command "create")
       (utopian-r/tasks/db:create app-file))
      ((equal command "recreate")
       (utopian-r/tasks/db:recreate app-file))
      ((equal command "migrate")
       (utopian-r/tasks/db:migrate app-file))
      ((equal command "migrate:status")
       (utopian-r/tasks/db:migration-status app-file))
      (t
       (error 'unknown-command
              :given command
              :candidates '("create" "recreate" "migrate" "migrate:status"))))))
