;;; -*- lexical-binding: t -*-

(p-require-package 'jabber 'melpa)

(defvar p-hipchat-account-number)
(defvar p-hipchat-user-number)
(defvar p-hipchat-rooms)
(defvar p-hipchat-nickname)
(defvar p-hipchat-emoticons-dir
  (expand-file-name (concat user-emacs-directory "hipchat/")))
(defvar p-hipchat-emoticons)

(require 'p-leader)
(require 'p-evil)
(require 'p-company)

(p-load-private "hipchat-settings.el")

(setq jabber-message-alert-same-buffer nil
      jabber-history-enabled t
      smiley-data-directory p-hipchat-emoticons-dir
      gnus-smiley-file-types '("pbm" "xpm" "gif" "png" "jpeg")
      jabber-alert-presence-hooks nil)

(defun p-hipchat-load-smileys ()
  (setq smiley-regexp-alist
        (->> (directory-files p-hipchat-emoticons-dir)
          (--keep (car (s-match "(\\w+)" it)))
          (--map (list (concat "\\(" it "\\)") 1 it))))
  (setq p-hipchat-emoticons
        (-map #'caddr smiley-regexp-alist)))

(with-eval-after-load 'jabber
  (p-hipchat-load-smileys)
  (add-to-list 'company-backends 'p-company-emoticon)
  ;; With great power comes great responsibility
  (-each (-map 'number-to-string '(1 2 3 4 5 6 7 8 9))
    '(lambda (num)
       (evil-define-key 'normal jabber-chat-mode-map num
         '(lambda () (interactive) (error "No fat-fingering!"))))))

(defun p-hipchat-connect ()
  (interactive)
  (let ((server "chat.hipchat.com"))
    (unless (ignore-errors (jabber-read-account))
      (jabber-connect
       (s-concat p-hipchat-account-number "_"
                 p-hipchat-user-number)
       server nil nil
       (password-store-get "Work/hipchat")
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

(defun p-set-up-jabber-chat-mode ()
  (require 'autosmiley)
  (electric-indent-mode 0)
  (electric-pair-mode 0)
  (autosmiley-mode 1))

(add-hook 'jabber-chat-mode-hook 'p-set-up-jabber-chat-mode)

;; Company backend

(defun p-company-emoticon (command &optional arg &rest ignored)
  (interactive (list 'interactive))

  (cl-case command
    (interactive (company-begin-backend 'p-company-emoticon))
    (prefix (and (eq major-mode 'jabber-chat-mode)
                 (company-grab "([a-z]+")))
    (candidates (--filter (string-prefix-p arg it)
                          p-hipchat-emoticons))))

;;;;;;;;;;;;;;
;; Bindings ;;
;;;;;;;;;;;;;;

(add-to-list 'evil-motion-state-modes 'jabber-roster-mode)

(provide 'p-jabber)

;;; p-jabber.el ends here
