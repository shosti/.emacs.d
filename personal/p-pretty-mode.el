;;; -*- lexical-binding: t -*-

(p-require-package 'pretty-mode 'melpa)

(require 'pretty-mode)

(pretty-deactivate-groups '(:logic) '(ruby-mode))
(pretty-activate-groups '(:greek))
(pretty-add-keywords 'ruby-mode '(("->" . ?\u03BB)))

(add-hook 'prog-mode-hook 'turn-on-pretty-if-desired)

(provide 'p-pretty-mode)

;;; p-pretty-mode.el ends here
