;;; -*- lexical-binding: t -*-

(p-require-package 'pretty-mode 'melpa)

(require 'pretty-mode)

;; Ruby doesn't really work with logic symbols
(pretty-deactivate-groups '(:logic) '(ruby-mode))
;; Stabby lambda!
(pretty-add-keywords 'ruby-mode '(("->" . ?\u03BB)))
(pretty-activate-groups '(:greek))

(add-hook 'prog-mode-hook 'turn-on-pretty-if-desired)

(provide 'p-pretty-mode)

;;; p-pretty-mode.el ends here
