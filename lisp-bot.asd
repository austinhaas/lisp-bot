(asdf:defsystem #:lisp-bot
  :description "A simple irc bot."
  :author "Austin Haas <austin@pettomato.com>"
  :licence "MIT"
  :version "0.0.1"
  :depends-on (#:cl-irc
               #:cl-ppcre
               #:bordeaux-threads)
  :components ((:module "src"
                :serial t
                :components ((:file "package")
                             (:file "lisp-bot")))))
