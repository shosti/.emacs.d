;;; -*- lexical-binding: t -*-

(p-require-package 'projectile 'melpa)

(require 'p-leader)

(projectile-global-mode)

;; Hack because it isn't exposed by projectile
(defvar projectile-prefix-map nil)
(define-prefix-command 'projectile-prefix-map)
(define-key projectile-prefix-map (kbd "f") 'projectile-find-file)
(define-key projectile-prefix-map (kbd "T") 'projectile-find-test-file)
(define-key projectile-prefix-map (kbd "t") 'projectile-toggle-between-implemenation-and-test)
(define-key projectile-prefix-map (kbd "g") 'projectile-grep)
(define-key projectile-prefix-map (kbd "b") 'projectile-switch-to-buffer)
(define-key projectile-prefix-map (kbd "o") 'projectile-multi-occur)
(define-key projectile-prefix-map (kbd "r") 'projectile-replace)
(define-key projectile-prefix-map (kbd "i") 'projectile-invalidate-cache)
(define-key projectile-prefix-map (kbd "R") 'projectile-regenerate-tags)
(define-key projectile-prefix-map (kbd "k") 'projectile-kill-buffers)
(define-key projectile-prefix-map (kbd "d") 'projectile-find-dir)
(define-key projectile-prefix-map (kbd "D") 'projectile-dired)
(define-key projectile-prefix-map (kbd "e") 'projectile-recentf)
(define-key projectile-prefix-map (kbd "a") 'projectile-ack)
(define-key projectile-prefix-map (kbd "c") 'projectile-compile-project)
(define-key projectile-prefix-map (kbd "p") 'projectile-test-project)
(define-key projectile-prefix-map (kbd "z") 'projectile-cache-current-file)
(define-key projectile-prefix-map (kbd "s") 'projectile-switch-project)

(p-set-leader-key "p" 'projectile-prefix-map)

(provide 'p-projectile)

;;; p-projectile.el ends here
