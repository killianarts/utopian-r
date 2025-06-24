(defsystem "utopian-r"
  :version "0.9.1"
  :author "Eitaro Fukamachi"
  :license "LLGPL"
  :description "Web application framework"
  :depends-on (
               "clack"
               "closer-mop"
               "alexandria"
               "lack"
               "mystic"
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
                 (:file "main"))))
  ;; :in-order-to ((test-op (test-op "utopian-r-tests")))
  )

(register-system-packages "lack-component" '(#:lack.component))
(register-system-packages "lack-request" '(#:lack.request))
(register-system-packages "lack-response" '(#:lack.response))
(register-system-packages "mystic" '(#:mystic))
(register-system-packages "mystic-file-mixin" '(#:mystic.template.file))
(register-system-packages "mystic-util" '(#:mystic.util))

;; (defsystem "utopian-r-tests"
;;   :pathname "tests"
;;   :depends-on (
;;                ;; "rove"
;;                )
;;   :perform (test-op (o c) (symbol-call :rove '#:run c)))
