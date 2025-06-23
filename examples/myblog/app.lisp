(defpackage #:myblog/app
  (:use #:cl
        #:myblog/config/routes
        #:myblog/config/application))
(in-package #:myblog/app)

(make-instance 'blog-app
               :routes *routes*
               :models #P"models/")
(defparameter *app* (make-instance 'blog-app
                                   :routes *routes*
                                   :models #P"models/"))

(defvar *handler* (clack:clackup *app* :use-thread nil :server :woo :port 5001 :address "127.0.0.1"))
