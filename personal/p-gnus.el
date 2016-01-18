;;; -*- lexical-binding: t -*-

(require 'p-options)
(require 'p-evil)
(require 'p-leader)
(require 'seq)
(require 's)

;;;;;;;;;;;;;;
;; Settings ;;
;;;;;;;;;;;;;;

(setq gnus-expert-user t
      gnus-select-method '(nntp "news.gmane.org")
      gnus-startup-file (concat user-emacs-directory ".newsrc")
      gnus-group-sort-function #'gnus-group-sort-by-rank
      gnus-gcc-mark-as-read t
      gnus-agent-queue-mail nil
      gnus-asynchronous t
      gnus-treat-hide-signature t
      mm-verify-option 'known
      mm-decrypt-option 'known
      mm-inline-text-html-with-images t
      bbdb-mua-pop-up nil
      bbdb-update-records-p t
      bbdb-ignore-message-alist '(("From" . "\\(notifications\\|no-?reply\\|news\\)@")
                                  ("From" . "[^@]*paper@dropbox.com")
                                  ("From" . "[^@]+@\\(gwene\\|public\\.gmane\\)\\.org"))
      message-send-mail-function #'message-send-mail-with-sendmail
      send-mail-function #'message-send-mail-with-sendmail
      sendmail-program (executable-find "msmtp")
      message-sendmail-f-is-evil t
      message-sendmail-envelope-from 'from
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-kill-buffer-on-exit t

      ;; Some settings to speed up startup a bit
      gnus-save-newsrc-file nil
      gnus-read-newsrc-file nil
      gnus-activate-level 5 ; don't query unsubscribed groups

      ;; Some more settings to make things look cooler (stolen from
      ;; http://doc.rix.si/cce/cce-gnus.html )
      gnus-summary-line-format "%U%R%z %(%&user-date; %-15,15f  %B%s%)\n"
      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
      gnus-sum-thread-tree-false-root ""
      gnus-sum-thread-tree-indent " "
      gnus-sum-thread-tree-leaf-with-other "├► "
      gnus-sum-thread-tree-root ""
      gnus-sum-thread-tree-single-leaf "╰► "
      gnus-sum-thread-tree-vertical "│"
      ;; Sorting and scoring, also mostly stolen from rrix
      gnus-thread-sort-functions '(gnus-thread-sort-by-number
                                   gnus-thread-sort-by-total-score)
      gnus-parameters '(("nnir.*"
                         (gnus-thread-sort-functions '((not gnus-thread-sort-by-date)))))

      gnus-use-adaptive-scoring '(word line)
      gnus-adaptive-word-length-limit 5
      gnus-adaptive-word-no-group-words t

      gnus-default-adaptive-score-alist
      '((gnus-unread-mark)
        (gnus-ticked-mark (from 4))
        (gnus-dormant-mark (from 5))
        (gnus-del-mark (from -4) (subject -1))
        (gnus-read-mark (from 4) (subject 2))
        (gnus-expirable-mark (from -1) (subject -1))
        (gnus-killed-mark (from -1) (subject -3))
        (gnus-kill-file-mark)
        (gnus-ancient-mark)
        (gnus-low-score-mark)
        (gnus-catchup-mark (from -1) (subject -1))))

(p-load-private "gnus-settings.el")

(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook #'turn-on-gnus-dired-mode))

(p-configure-feature gnus
  (require 'gnus-art)
  (require 'message)
  (require 'bbdb)
  (require 'bbdb-gnus)
  (require 'bbdb-message)
  (bbdb-initialize 'gnus 'message)
  (bbdb-mua-auto-update-init 'gnus 'message)
  (define-key gnus-summary-mode-map (kbd "C-c C-o") #'p-gnus-gmane-link)

  (add-hook 'gnus-summary-exit-hook #'gnus-summary-bubble-group)
  (add-hook 'gnus-group-mode-hook #'gnus-topic-mode)
  (add-hook 'kill-emacs-hook #'p-quit-gnus)
  (add-hook 'gnus-select-group-hook #'gnus-group-set-timestamp)
  (add-to-list 'message-subscribed-address-functions #'gnus-find-subscribed-addresses)
  (add-to-list 'gnus-buttonized-mime-types "multipart/signed"))

(defun p-quit-gnus ()
  "Quit gnus if it is suspended."
  (ignore-errors (gnus-group-exit)))

;;;;;;;;;;;;;;
;; Bindings ;;
;;;;;;;;;;;;;;

(--each '(gnus-browse-mode gnus-server-mode)
  (add-to-list 'evil-motion-state-modes it)
  (setq evil-emacs-state-modes (delq it evil-emacs-state-modes)))

(p-add-hjkl-bindings gnus-summary-mode-map 'emacs)
(p-add-hjkl-bindings gnus-article-mode-map 'emacs
  "v" #'evil-visual-char
  "V" #'evil-visual-line
  "y" #'evil-yank)
(p-add-hjkl-bindings gnus-group-mode-map 'emacs
  "q" #'gnus-group-suspend ; to prevent restarting all the time
  "Q" #'gnus-group-exit
  "l" #'gnus-group-list-groups
  "Gj" #'gnus-group-jump-to-group)

(p-configure-feature gnus-srver
  (define-key gnus-server-mode-map (kbd "M-o") nil)
  (define-key gnus-server-mode-map
    (kbd "C-x o") 'gnus-server-open-all-servers))

(p-set-leader-key
  "G" 'gnus)

(defun p-gnus-gmane-link ()
  "Grabs the article name and generates a url found in Gmane.
  If successful, sends it to the local web browser."
  (interactive)
  (let ((url
         (with-current-buffer gnus-article-buffer
           (let ((msgids (split-string (aref gnus-current-headers 8) "[ :]")))
             (cond ((and (equal (substring (second msgids) 0 6)
                                "gwene.")
                         (goto-char (point-max))
                         (search-backward "Link" (point-min) 'noerror))
                    (shr-copy-url)
                    (current-kill 0))
                   ((equal (substring (second msgids) 0 6)
                           "gmane.")
                    (concat "http://comments.gmane.org/" (second msgids) "/" (third msgids))))))))
    (if url
        (browse-url (message url))
      (message "Couldn't find any likely url"))))

(defun p-mail-addresses ()
  "Return a list of mail addresses."
  (seq-map (lambda (acct)
             (cadr (assq 'nnimap-user acct)))
           gnus-secondary-select-methods))

(defun p-unread-mail-p ()
  "Return non-nil if there is unread mail in any account."
  (< 0 (seq-reduce #'+
                   (seq-map (lambda (addr)
                              (string-to-number
                               (shell-command-to-string
                                (format "doveadm search -u %s UNSEEN | wc -l" addr))))
                            (p-mail-addresses)) 0)))

(provide 'p-gnus)

;;; p-gnus.el ends here
