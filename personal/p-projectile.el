;;; -*- lexical-binding: t -*-

(p-require-package 'projectile)

(require 'p-key-chord)

(setq projectile-keymap-prefix [key-chord ?, ?. ?p])

(projectile-global-mode)

(provide 'p-projectile)

;;; p-projectile.el ends here
