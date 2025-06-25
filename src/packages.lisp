(uiop:define-package #:utopian-r
  (:use #:cl)
  (:import-from #:clack
                ;; #:clackup
                )
  (:import-from #:closer-mop)
  (:import-from #:cl-ppcre)
  (:import-from #:alexandria
                ;; #:ensure-car
                ;; #:when-let
                ;; #:hash-table-plist
                )
  (:import-from #:just-getopt-parser
                ;; #:getopt
                ;; #:unknown-option
                ;; #:required-argument-missing
                )
  (:import-from #:mystic
                ;; #:render-template
                ;; #:prompt-option
                )
  (:import-from #:mystic.template.file
                ;; #:file
                ;; #:file-mixin
                )
  (:import-from #:mystic.util
                ;; #:render-string
                ;; #:write-file
                )
  (:import-from #:lack)
  (:import-from #:lsx)
  (:import-from #:myway
                ;; #:make-mapper
                ;; #:connect
                ;; #:next-route
                )
  (:import-from #:safety-params
                ;; #:validation-error
                )
  (:export
   ;; cli
   #:new-command
   #:generate-command
   #:server-command
   #:db-command
   ;; context
   #:to-app
   #:call
   #:*response*
   #:response-headers
   ;; views
   #:defview
   #:utopian-r-view
   #:utopian-r-view-class
   #:utopian-r-view-direct-superclasses
   #:render-html
   #:render-object
   #:html-view
   #:html-view-class
   ;; config
   #:*config-dir*
   #:environment-config
   #:config
   #:db-settings
   #:getenv
   #:getenv-int
   #:appenv
   ;; errors
   #:utopian-r-error
   #:utopian-r-task-error
   #:simple-task-error
   #:invalid-arguments
   #:unknown-command
   #:file-not-found
   #:system-not-found
   #:directory-already-exists
   ;; app
   #:application
   #:defapp
   #:with-config
   #:make-request
   #:make-response
   #:on-exception
   #:on-validation-error
   ;; routes
   #:defroutes
   #:routes
   #:routes-mapper
   #:routes-controllers-directory
   #:route
   #:next-route ;; from MyWay
   ;; tasks
   #:server
   #:new
   #:ask-for-value
   #:use-value
   ;; tasks/db
   #:connect
   #:create
   #:drop
   #:recreate
   #:reset
   #:migrate
   #:migration-status
   #:generate-migrations
   ;; skeleton
   #:standard-project
   ;; exceptions
   #:http-exception
   #:http-redirect
   #:http-exception-code
   #:http-redirect-to
   #:http-redirect-code
   #:throw-code
   #:redirect-to
   ;; file-loader
   #:load-file
   #:eval-file
   #:intern-rule
   ))
