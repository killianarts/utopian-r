(defsystem "utopian-r"
  :version "0.9.1"
  :author "Eitaro Fukamachi"
  :license "LLGPL"
  :description "Web application framework"
  :depends-on (
               "clack"
               "closer-mop"
               "alexandria"
               "lack" "lack-request" "lack-response" "lack-component"
               "mystic" "mystic-file-mixin" 
               "lsx"
               "myway" 
               "safety-params"
               "cl-ppcre"
               "mito"
               "cl-dbi"
               "just-getopt-parser"
               )
  :components ((:module src
                :serial t
                :components
                ((:file "packages")
                 (:file "file-loader")
                 (:file "exceptions")
                 (:file "context")
                 (:file "config")
                 (:file "routes")
                 (:file "errors")
                 (:file "skeleton")
                 (:file "tasks")
                 (:file "views")
                 (:file "app")
                 (:file "main")
                 (:module "task-utils"
                  :pathname "tasks"
                  :components ((:file "db")))
                 (:module cli
                  :components ((:file "new")
                               (:file "db")
                               (:file "server")
                               (:file "generate"))))))
  ;; :in-order-to ((test-op (test-op "utopian-r-tests")))
  )

;; (defsystem "utopian-r-tests"
;;   :pathname "tests"
;;   :depends-on (
;;                ;; "rove"
;;                )
;;   :perform (test-op (o c) (symbol-call :rove '#:run c)))
