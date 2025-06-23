(defpackage #:utopian-r-tests/tasks
  (:use #:cl
        #:rove
        #:utopian-r/tasks
        #:utopian-r-tests/utils))
(in-package #:utopian-r-tests/tasks)

(defun make-project-name (&optional (prefix "new-project-"))
  (concatenate 'string prefix (random-string)))

(deftest task-new-tests
    (let* ((project-name (make-project-name))
           (destination (merge-pathnames project-name
                                         uiop:*temporary-directory*)))
      (ok (new destination
               :description ""
               :author ""
               :database "sqlite3"
               :license ""))))
