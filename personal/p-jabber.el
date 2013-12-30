(p-require-package 'jabber)

(defvar p-hipchat-account-number)
(defvar p-hipchat-user-number)
(defvar p-hipchat-rooms)
(defvar p-hipchat-nickname)

(p-load-private "hipchat.el")

(setq jabber-message-alert-same-buffer nil
      jabber-history-enabled t)

(defun p-hipchat-connect ()
  (interactive)
  (let ((server "chat.hipchat.com"))
    (unless (ignore-errors (jabber-read-account))
      (jabber-connect
       (s-concat p-hipchat-account-number "_"
                 p-hipchat-user-number)
       server nil nil
       (p-password 'hipchat-password)
       server 5223 'ssl))))

(defun p-hipchat-join-room (room)
  (interactive "M")
  (jabber-groupchat-join
   (jabber-read-account)
   (s-concat p-hipchat-account-number "_" room "@conf.hipchat.com")
   p-hipchat-nickname))

(defun p-hipchat-join ()
  (interactive)
  (require 'jabber)
  (p-hipchat-connect)
  (sleep-for 5)
  (--each p-hipchat-rooms
    (p-hipchat-join-room it)))

(defun p-hipchat-rooms ()
  (cons
   '("roster" . "*-jabber-roster-*")
   (->> (buffer-list)
     (-map
      (lambda (b)
        (-if-let
            (chat-name
             (nth 2
                  (s-match
                   "\\*-jabber-\\(groupchat-[0-9]+_\\|chat-\\)\\([^*]+\\)-\\*"
                   (buffer-name b))))
            (cons (->> chat-name
                    (s-replace "_" " ")
                    (s-chop-suffix "@conf.hipchat.com"))
                  (buffer-name b)))))
     (-filter 'car))))

(defun p-hipchat-switch-to-room ()
  (interactive)
  (let* ((chatrooms (p-hipchat-rooms))
         (room-names (-map 'car chatrooms))
         (room
          (completing-read "Room: " room-names nil nil nil nil (car room-names))))
    (switch-to-buffer (cdr (assoc room chatrooms)))))

(global-set-key (kbd "C-c h") 'p-hipchat-switch-to-room)

(provide 'p-jabber)

;;; p-jabber.el ends here
