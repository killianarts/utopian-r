(defsystem "utopian-r-tests"
  :pathname "tests"
  :depends-on (
               ;; "rove"
               )
  :perform (test-op (o c) (symbol-call :rove '#:run c)))
