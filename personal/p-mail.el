(require 'p-leader)
(require 'p-evil)

;; General mail settings

(defvar p-mu4e-account-alist)

(p-load-private "mail-settings.el")

(require 'smtpmail)

(setq message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/local/bin/msmtp"
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-kill-buffer-on-exit t)

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

(if (ignore-errors (require 'mu4e-autoload))
    (eval-after-load 'mu4e
      '(progn
         (setq mu4e-sent-messages-behavior 'delete
               mu4e-get-mail-command "offlineimap")
         (add-hook 'mu4e-compose-pre-hook 'p-mu4e-set-account)

         (--each (list mu4e-main-mode-map mu4e-headers-mode-map)
           (evil-add-hjkl-bindings it 'emacs
             "J" 'mu4e~headers-jump-to-maildir))))

  (defun mu4e ()
    (interactive)
    (error "mu4e not installed on this system")))

(p-set-leader-key "M" 'mu4e)


(provide 'p-mail)

;;; p-mail.el ends here
