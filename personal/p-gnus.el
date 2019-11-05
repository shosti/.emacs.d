;;; -*- lexical-binding: t -*-

(p-require-package 'bbdb 'gnu)

(require 'p-options)
(require 'p-evil)
(require 'p-leader)
(require 'seq)
(require 's)

;;;;;;;;;;;;;;
;; Settings ;;
;;;;;;;;;;;;;;

;; A few parameters set in private settings
(defvar p-gnus-parameters nil)
(defvar p-gnus-checked-accounts nil)

(p-load-private "gnus-settings.el")

(setq gnus-expert-user t
      gnus-select-method '(nntp "news.gmane.org")
      gnus-backup-startup-file t
      gnus-group-sort-function #'gnus-group-sort-by-rank
      gnus-gcc-mark-as-read t
      gnus-agent-queue-mail nil
      gnus-asynchronous t
      gnus-treat-hide-signature t
      gnus-completing-read-function #'gnus-ido-completing-read
      gnus-inhibit-images t
      mm-verify-option 'known
      mm-decrypt-option 'known
      mm-inline-text-html-with-images t
      bbdb-mua-pop-up nil
      bbdb-update-records-p t
      bbdb-ignore-message-alist '(("From" . ".+@debbugs\\.gnu\\.org")
                                  ("From" . "\\(notifications\\|no[-_]?reply\\|news\\)@")
                                  ("From" . "[^@]*paper\\(\\+[^@]+\\)?@dropbox.com")
                                  ("From" . "[^@]+@\\(gwene\\|public\\.gmane\\)\\.org")
                                  ("From" . "invitations@linkedin.com"))
      message-send-mail-function #'message-send-mail-with-sendmail
      send-mail-function #'message-send-mail-with-sendmail
      sendmail-program (executable-find "msmtp")
      message-sendmail-f-is-evil t
      message-sendmail-envelope-from 'from
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-kill-buffer-on-exit t
      message-fill-column 80
      message-valid-fqdn-regexp "[a-z0-9][-.a-z0-9]+\\.[a-z]+"
      nnmail-split-fancy-match-partial-words t

      ;; icalendar!
      gnus-icalendar-org-capture-file "~/org/cal.org"
      gnus-icalendar-org-capture-headline '("Calendar")

      ;; Some settings to speed up startup a bit
      gnus-save-newsrc-file nil
      gnus-read-newsrc-file nil
      gnus-activate-level 5 ; don't query unsubscribed groups

      ;; Some more settings to make things look cooler (stolen from
      ;; http://doc.rix.si/cce/cce-gnus.html )
      gnus-summary-line-format "%U%R%z %(%~(pad-right 17)&user-date; %-15,15f  %B%s%)\n"
      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject
      gnus-sum-thread-tree-false-root ""
      gnus-sum-thread-tree-indent " "
      gnus-sum-thread-tree-leaf-with-other "├► "
      gnus-sum-thread-tree-root ""
      gnus-sum-thread-tree-single-leaf "╰► "
      gnus-sum-thread-tree-vertical "│"
      ;; Sorting and scoring, also mostly stolen from rrix
      gnus-thread-sort-functions '((not gnus-thread-sort-by-number)
                                   p-gnus-thread-sort-by-importance)
      gnus-parameters (append p-gnus-parameters
                              '(("nnir.*"
                                 (gnus-thread-sort-functions '((not gnus-thread-sort-by-number))))))

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

(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook #'turn-on-gnus-dired-mode))

(with-eval-after-load 'gnus
  (require 'gnus-art)
  (require 'gnus-icalendar)
  (require 'message)
  (require 'bbdb)
  (require 'bbdb-gnus)
  (require 'bbdb-message)
  (bbdb-initialize 'gnus 'message)
  (define-key gnus-summary-mode-map (kbd "C-c C-o") #'p-gnus-gmane-link)
  (gnus-icalendar-setup)

  (add-hook 'gnus-summary-exit-hook #'gnus-summary-bubble-group)
  (add-hook 'gnus-group-mode-hook #'gnus-topic-mode)
  (add-hook 'kill-emacs-hook #'p-quit-gnus)
  (add-hook 'gnus-select-group-hook #'gnus-group-set-timestamp)
  (add-hook 'message-mode-hook #'p-set-up-message-mode)
  (add-to-list 'message-subscribed-address-functions #'gnus-find-subscribed-addresses)
  (add-to-list 'gnus-buttonized-mime-types "multipart/signed"))

(defun p-set-up-message-mode ()
  (company-mode 1)
  (company-emoji-init))

(defun p-quit-gnus ()
  "Quit gnus if it is suspended."
  (ignore-errors (gnus-group-exit)))

(defun p-gnus-thread-sort-by-importance (h1 h2)
  "Sort threads by importance postitive vs 0 vs negative score."
  (> (p-gnus-score-normalize (gnus-thread-total-score h1))
     (p-gnus-score-normalize (gnus-thread-total-score h2))))

(defun p-gnus-score-normalize (n)
  "Normalize a score number to 1, 0, or -1."
  (cond ((zerop n) 0)
        ((> n 0) 1)
        (t -1)))

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

(with-eval-after-load 'gnus-srver
  (define-key gnus-server-mode-map (kbd "M-o") nil)
  (define-key gnus-server-mode-map
    (kbd "C-x o") 'gnus-server-open-all-servers))

(with-eval-after-load 'gnus-topic
  (define-key gnus-topic-mode-map (kbd "<tab>") #'gnus-topic-select-group))

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
                                (format "doveadm search -u %s UNSEEN MAILBOX INBOX | wc -l" addr))))
                            p-gnus-checked-accounts) 0)))

(with-eval-after-load 'gnus-hydra
  (define-key hydra-gnus-group-group/keymap "j" #'gnus-group-jump-to-group))

(provide 'p-gnus)

;;; p-gnus.el ends here
