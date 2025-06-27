(in-package #:{{project-name}})
{{#actions}}

(defun {{name}} (params)
  (declare (ignore params))
  (render-html '{{name}}-page))
{{/actions}}
