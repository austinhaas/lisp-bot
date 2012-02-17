(defpackage #:lisp-bot
  (:use #:cl
        #:cl-irc
        #:cl-ppcre
        #:bordeaux-threads)
  (:export #:start-bot))
