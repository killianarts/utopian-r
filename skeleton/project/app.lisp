(in-package #:{{project-name}})

(make-instance '{{project-name}}-app
               :routes *routes*
               :models #P"models/")
