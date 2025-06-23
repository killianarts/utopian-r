(defsystem "myblog"
  :author "Eitaro Fukamachi"
  :version "0.1.0"
  :depends-on ("utopian-r" "lack")
  :components ((:module config
                :components
                ((:file "application"
                  :file "routes"
                  :file "environments/local")))
               ((:file "app")
                (:file "main"))))

(register-system-packages "lack-component" '(#:lack.component))
