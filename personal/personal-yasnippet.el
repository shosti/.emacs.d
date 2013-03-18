(require 'yasnippet)

(setq yas-snippet-dirs (list (concat user-emacs-directory "snippets")))
(yas-reload-all)
(yas-global-mode 1)

(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "M-RET") 'yas-expand)

(provide 'personal-yasnippet)
