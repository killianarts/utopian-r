(uiop:define-package #:utopian-r/context
  (:use #:cl)
  (:use-reexport #:lack
                 #:lack.response
                 #:lack.request
                 #:lack.component)
  (:import-from #:lack.component
                #:to-app
                #:call)
  (:export #:to-app
           #:call
           #:*request*
           #:*response*))
(in-package #:utopian-r/context)

(defvar *request*)
(defvar *response*)
