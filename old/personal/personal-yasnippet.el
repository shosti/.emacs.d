(require 'yasnippet)

(setq yas-snippet-dirs (list (concat user-emacs-directory "snippets")))
(yas-reload-all)
(yas-global-mode 1)

(provide 'personal-yasnippet)
