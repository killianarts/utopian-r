(in-package #:{{project-name}})

`(:databases
  ((:maindb . (:postgres
               :database-name "{{project-name}}"
               :username "{{project-name}}"
               :password ""))))
