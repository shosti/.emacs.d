;;; -*- lexical-binding: t -*-

(require 'p-options)
(require 'p-evil)
(require 'p-leader)

;;;;;;;;;;;;;;
;; Settings ;;
;;;;;;;;;;;;;;

(p-configure-feature gnus
  (p-load-private "gnus-settings.el")
  (define-key gnus-summary-mode-map (kbd "C-c C-o") 'p-gnus-gmane-link)
  (setq gnus-expert-user t))

;;;;;;;;;;;;;;
;; Bindings ;;
;;;;;;;;;;;;;;

(--each '(gnus-browse-mode gnus-server-mode)
  (add-to-list 'evil-motion-state-modes it)
  (setq evil-emacs-state-modes (delq it evil-emacs-state-modes)))

(p-add-hjkl-bindings gnus-summary-mode-map 'emacs)
(p-add-hjkl-bindings gnus-article-mode-map 'emacs)
(p-add-hjkl-bindings gnus-group-mode-map 'emacs
  "Gj" 'gnus-group-jump-to-group)

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

(provide 'p-gnus)

;;; p-gnus.el ends here
