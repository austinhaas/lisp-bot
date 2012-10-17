(asdf:defsystem #:lisp-bot
  :description "cl-irc extensions to support bot making."
  :author "Austin Haas <austin@pettomato.com>"
  :licence "MIT"
  :version "0.0.2"
  :depends-on (#:cl-irc
               #:cl-ppcre
               #:bordeaux-threads)
  :components ((:module "src"
                :serial t
                :components ((:file "package")
                             (:file "lisp-bot")))))
