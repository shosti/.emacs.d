;;; -*- lexical-binding: t -*-

(p-require-package 'prodigy 'local)

(require 'prodigy)
(require 'p-leader)
(require 'p-evil)

(setq prodigy-view-truncate-by-default nil)
(p-load-private "prodigy-settings.el")
(add-to-list 'evil-emacs-state-modes 'prodigy-mode)
(evil-add-hjkl-bindings prodigy-mode-map)

(p-set-leader-key "y" 'prodigy)

(provide 'p-prodigy)

;;; p-prodigy.el ends here
