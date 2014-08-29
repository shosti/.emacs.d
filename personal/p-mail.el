(require 'p-leader)
(require 'p-evil)

;; General mail settings

(defvar p-mu4e-account-alist)

(defun p-mail-set-up? ()
  (and (executable-find "mu")
     (executable-find "msmtp")
     (executable-find "mbsync")
     (executable-find "pandoc")
     (file-exists-p (expand-file-name "~/Maildir"))
     (--any? (s-contains? "mu4e" it) load-path)))

(if (p-mail-set-up?)
    (progn (autoload 'mu4e "mu4e" "" t)
           (eval-after-load 'mu4e '(p-config-mu4e)))
  (defun mu4e ()
    (interactive)
    (error "mu4e not installed on this system")))

;; Stolen from the mu4e manual
(defun p-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var)) p-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) p-mu4e-account-alist)
                             nil t nil nil (caar p-mu4e-account-alist))))
         (account-vars (cdr (assoc account p-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'p-mu4e-set-account)

(defun p-mail-cycle-urls ()
  "Jump through hyperlinks, like help or gnus."
  (interactive)
  (let ((start (point))
        (forward-count (when (looking-at mu4e-view-url-regexp) 2)))
    (unless (re-search-forward mu4e-view-url-regexp nil t forward-count)
      (goto-char (point-min))
      (unless (re-search-forward mu4e-view-url-regexp nil t)
        (goto-char start)
        (error "No URLs in message.")))
    (re-search-backward mu4e-view-url-regexp)))

(defun p-set-up-mu4e-compose-mode ()
  (turn-on-orgstruct++)
  (setq-local fill-column 80))

(add-hook 'mu4e-compose-mode-hook 'p-set-up-mu4e-compose-mode)

(defun p-config-mu4e ()
  (p-load-private "mail-settings.el")

  (require 'smtpmail)
  (require 'org-mu4e)

  (imagemagick-register-types)

  (setq message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program (executable-find "msmtp")
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-kill-buffer-on-exit t
        mu4e-sent-messages-behavior 'delete
        mu4e-get-mail-command "mbsync -a"
        mu4e-change-filenames-when-moving t
        mu4e-headers-skip-duplicates t
        mu4e-attachment-dir (expand-file-name "~/Downloads")
        mu4e-view-show-images t
        mu4e-html2text-command "pandoc -f html -t plain"
        mu4e-view-html-plaintext-ratio-heuristic 1000 ; Don't want html mail EVER
        mu4e-confirm-quit nil)

  ;; Full-screen hackery, similar to magit
  (defadvice mu4e (around mu4e-fullscreen activate)
    (window-configuration-to-register :mu4e-fullscreen)
    ad-do-it
    (delete-other-windows))

  (defadvice mu4e-quit (after mu4e-restore activate)
    (jump-to-register :mu4e-fullscreen))

  ;; Get some good keybindings
  (--each '(mu4e-main-mode
            mu4e-headers-mode
            mu4e~update-mail-mode
            mu4e-about-mode)
    (add-to-list 'evil-emacs-state-modes it))
  (add-to-list 'evil-motion-state-modes 'mu4e-view-mode)

  (evil-define-key 'motion mu4e-view-mode-map "n" 'mu4e-view-headers-next)
  (evil-define-key 'motion mu4e-view-mode-map "F" 'mu4e-compose-forward)
  (--each (list mu4e-main-mode-map mu4e-headers-mode-map)
    (evil-add-hjkl-bindings it 'emacs
      "J" 'mu4e~headers-jump-to-maildir))

  (define-key mu4e-view-mode-map (kbd "TAB") 'p-mail-cycle-urls)
  (define-key mu4e-view-mode-map (kbd "RET") (kbd "M-RET")))

(p-set-leader-key "M" 'mu4e)

(provide 'p-mail)

;;; p-mail.el ends here
