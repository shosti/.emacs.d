;;; -*- lexical-binding: t -*-

(p-require-package 'pretty-mode 'melpa)

(require 'pretty-mode)

(pretty-deactivate-groups '(:logic) '(ruby-mode))
(pretty-activate-groups '(:greek))
(pretty-add-keywords 'ruby-mode '(("->" . ?\u03BB)))

(global-pretty-mode 1)

(provide 'p-pretty-mode)
