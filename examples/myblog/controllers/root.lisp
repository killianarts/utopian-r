(defpackage #:myblog/controllers/root
  (:use #:cl
        #:utopian-r
        #:myblog/views/root)
  (:export #:index))
(in-package #:myblog/controllers/root)

(defun index (params)
  (declare (ignore params))
  (render-html 'index-page))
