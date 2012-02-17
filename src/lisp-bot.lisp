(in-package #:lisp-bot)

(defparameter *nick* nil)
(defparameter *attention-nick* nil)
(defparameter *connection* nil)

(defun make-attention-prefix (nick)
  (format nil "^(?i)~A[,:]\\s+" nick))

(defun bot-message-p (message)
  (scan *attention-nick* (car (last (arguments message)))))

(defun msg-hook (message)
  (handler-bind
      ((serious-condition (lambda (c)
                            (format *trace-output* "Caught error: ~A~%" c)
                            #+nil (sb-debug:backtrace 10 *trace-output*)
                            (format *trace-output* "~A~%"
                                    (nthcdr 10 (sb-debug:backtrace-as-list)))
                            (return-from msg-hook))))
    (progn
      (when (bot-message-p message)
        (let ((channel (first (arguments message))))
          (privmsg *connection* channel "Leave me alone."))))))

(defun start-bot (nick server password &rest channels)
  (setf *nick* nick)
  (setf *attention-nick* (make-attention-prefix nick))
  (setf *connection* (connect :nickname nick :server server :password password))
  (mapcar #'(lambda (channel) (join *connection* channel)) channels)
  (add-hook *connection* 'irc::irc-privmsg-message 'msg-hook)
  (flet ((do-loop ()
           (loop
             (handler-bind
                 ((no-such-reply
                    #'(lambda (c)
                        (declare (ignore c))
                        (invoke-restart 'continue))))
               (read-message-loop *connection*)))))
    (make-thread #'do-loop :name (format nil "lisp-bot: ~A" nick))))
