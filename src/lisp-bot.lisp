(in-package #:lisp-bot)

(defparameter *threads* (make-hash-table))

(defun message-loop (connection)
  (loop
    (handler-bind
        ((irc:no-such-reply
           #'(lambda (c)
               (declare (ignore c))
               (invoke-restart 'continue))))
      (irc:read-message connection))))

(defun start-processing-messages (connection)
  (let ((thread (make-thread (lambda () (message-loop connection))
                             :name (format nil "lisp-bot: ~A" (irc:nickname (irc:user connection))))))
    (setf (gethash connection *threads*) thread)))

(defun stop-processing-messages (connection)
  (let ((thread (gethash connection *threads*)))
    (when thread
      (destroy-thread thread)
      (remhash connection *threads*))))

(defun make-attention-prefix (nick)
  (format nil "^(?i)~A[,:]\\s+" nick))

(defclass user ()
  ((nick :initarg :nick :accessor :nick )))