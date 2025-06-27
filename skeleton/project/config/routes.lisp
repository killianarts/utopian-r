(in-package #:{{project-name}})

(defroutes *routes* ()
  (:controllers #P"../controllers/"))

(route :GET "/" "root:index")
