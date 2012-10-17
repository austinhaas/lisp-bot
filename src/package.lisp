(defpackage #:lisp-bot
  (:use #:cl
        #:cl-ppcre
        #:bordeaux-threads)
  (:export #:start-processing-messages
           #:stop-processing-messages
           #:make-attention-prefix
           ))
