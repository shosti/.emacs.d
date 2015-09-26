;;; -*- lexical-binding: t -*-

(require 'request)
(require 'json)

(defvar *slack-token*)

(defun p-slack-token ()
  (when (null *slack-token*)
    (setq *slack-token* (password-store-get "Work/slack-token")))
  *slack-token*)

(defun p-slack-mark-all ()
  (request
   "https://slack.com/api/channels.list"
   :parser #'json-read
   :data `(("token" . ,(p-slack-token)) ("exclude_archived" . "1"))
   :success (lambda (_key data &rest _)
              (seq-do (lambda (chan)
                        (let ((chan-id (cdr (assq 'id chan))))
                          (p-slack-mark chan-id)))
                      (cdr (assq 'channels data))))))

(defun p-slack-mark (chan-id)
  (message "RESETTING %s" chan-id)
  (let ((ts (number-to-string (float-time))))
    (request
     "https://slack.com/api/channels.mark"
     :parser #'json-read
     :type "POST"
     :data (list (cons "token" (p-slack-token))
                 (cons "channel" chan-id)
                 (cons "ts" ts))
     :success (lambda (_key data &rest _)
                (message "DATA: %s" data))
     :error (lambda (key error &rest _)
              (message "ERROR: %s %s" key err)))))

(provide 'p-slack)

;;; p-slack.el ends here
