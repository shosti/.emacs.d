;;; -*- lexical-binding: t -*-

(require 'p-evil)

(p-require-package 'makey)
(p-require-package 'discover)

(global-discover-mode 1)

(add-to-list 'evil-emacs-state-modes 'makey-key-mode)

(provide 'p-discover)

;;; p-discover.el ends here
