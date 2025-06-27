(in-package #:{{project-name}})

`(:databases
  ((:maindb . (:mysql
               :database-name "{{project-name}}"
               :username "{{project-name}}"
               :password ""))))
