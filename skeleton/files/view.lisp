(in-package #:{{project-name}})

(lsx:enable-lsx-syntax)
{{#actions}}

(defview {{name}}-page ()
  ()
  (:metaclass html-view-class)
  (:render
   <html>
   <head>
   <title>{{name}} | {{project-name}}</title>
     </head>
     <body>
       <h1>{{name}}</h1>
     </body>
   </html>))
{{/actions}}
