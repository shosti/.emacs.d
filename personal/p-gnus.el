;;; -*- lexical-binding: t -*-

(require 'p-options)
(require 'p-evil)
(require 'p-leader)

;;;;;;;;;;;;;;
;; Settings ;;
;;;;;;;;;;;;;;

(p-configure-feature gnus
  (p-load-private "gnus-settings.el")
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

(provide 'p-gnus)

;;; p-gnus.el ends here
