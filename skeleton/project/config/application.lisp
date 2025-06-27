(in-package #:{{project-name}})

(defapp {{project-name}}-app ()
  ()
  (:config #P"environments/")
  (:content-type "text/html; charset=utf-8"))

(defmethod to-app ((app {{project-name}}-app))
  (builder
   (:static
    :path (lambda (path)
            (if (ppcre:scan "^(?:/assets/|/robot\\.txt$|/favicon\\.ico$)" path)
                path
                nil))
    :root (asdf:system-relative-pathname :{{project-name}} #P"public/"))
   :accesslog
   (:mito (db-settings :maindb))
   :session
   (call-next-method)))
