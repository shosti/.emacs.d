;;; -*- lexical-binding: t -*-

(p-require-package 'yasnippet)

(require 'yasnippet)

(setq yas-snippet-dirs (list (concat user-emacs-directory "snippets")))
(yas-global-mode 1)

(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "M-RET") 'yas-expand)

(provide 'p-yasnippet)

;;; p-yasnippet.el ends here
