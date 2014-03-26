;;; -*- lexical-binding: t -*-

(p-require-package 'jabber)

(defvar p-hipchat-account-number)
(defvar p-hipchat-user-number)
(defvar p-hipchat-rooms)
(defvar p-hipchat-nickname)
(defvar p-hipchat-emoticons-dir
  (expand-file-name (concat user-emacs-directory "hipchat/")))

(require 'p-leader)
(require 'p-evil)

(p-load-private "hipchat-settings.el")

(setq jabber-message-alert-same-buffer nil
      jabber-history-enabled t
      smiley-data-directory p-hipchat-emoticons-dir
      gnus-smiley-file-types '("pbm" "xpm" "gif" "png" "jpeg"))

(defun p-hipchat-load-smileys ()
  (setq smiley-regexp-alist
        (->> (directory-files p-hipchat-emoticons-dir)
          (--keep (car (s-match "(\\w+)" it)))
          (--map (list (concat "\\(" it "\\)") 1 it)))))

(eval-after-load 'jabber 'p-hipchat-load-smileys)

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
  (p-await (lambda ()
             (eq (plist-get (car jabber-connections) :state)
                 :session-established)))
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
             (nth 2 (s-match
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
          (completing-read "Room: " room-names nil nil nil nil
                           (car room-names))))
    (switch-to-buffer (cdr (assoc room chatrooms)))))

(defun p-set-up-jabber-chat-mode ()
  (require 'autosmiley)
  (autosmiley-mode 1))

(add-hook 'jabber-chat-mode-hook 'p-set-up-jabber-chat-mode)

;;;;;;;;;;;;;;
;; Bindings ;;
;;;;;;;;;;;;;;

(add-to-list 'evil-motion-state-modes 'jabber-roster-mode)
(p-set-leader-key "j" 'p-hipchat-switch-to-room)

(eval-after-load 'jabber
  '(progn
     (-each (-map 'number-to-string '(1 2 3 4 5 6 7 8 9))
            '(lambda (num)
               (evil-define-key 'normal jabber-chat-mode-map num
                 '(lambda () (interactive) (error "No fat-fingering!")))))))

(provide 'p-jabber)

;;; p-jabber.el ends here
