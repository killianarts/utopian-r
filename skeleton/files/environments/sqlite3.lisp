(in-package #:{{project-name}})

`(:databases
  ((:maindb . (:sqlite3
               :database-name ,(asdf:system-relative-pathname :{{project-name}} #P"db/{{environment}}.db")))))
