(defsystem "myblog"
  :author "Eitaro Fukamachi"
  :version "0.1.0"
  :depends-on ("utopian-r" "lack" "lack-component")
  :components ((:file "app")
               (:file "main")
               (:module "config"
                :components
                ((:file "application")
                 (:file "routes")
                 (:file "environments/local")))))

