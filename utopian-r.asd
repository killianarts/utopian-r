(defsystem "utopian-r"
  :version "0.9.1"
  :author "Eitaro Fukamachi"
  :license "LLGPL"
  :description "Web application framework"
  :depends-on (
               "clack"
               "closer-mop"
               "alexandria"
               "mystic"
               "lack"
               "lack-component" "lack-request" "lack-response"
               "mystic" "mystic-file-mixin"
               "lsx"
               "myway"
               "safety-params"
               )
  :components ((:module src
                :components
                ((:file "file-loader")
                 (:file "exceptions")
                 (:file "context")
                 (:file "config")
                 (:file "routes")
                 (:file "errors")
                 (:file "skeleton")
                 (:file "tasks")
                 (:file "views")
                 (:file "main")
                 (:file "app"))))
  :in-order-to ((test-op (test-op "utopian-r-tests"))))

(register-system-packages "lack-component" '(#:lack.component))
(register-system-packages "lack-request" '(#:lack.request))
(register-system-packages "lack-response" '(#:lack.response))
(register-system-packages "mystic" '(#:mystic.util))
(register-system-packages "mystic-file-mixin" '(#:mystic.template.file))
