;;; -*- lexical-binding: t -*-

;;; Miscellaneous keybindings

(personal-require-package 'starter-kit-bindings)

;; window management
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-o") 'other-window)

;; misc
(global-set-key (kbd "C-x C-z") 'ns-do-hide-emacs)
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c g") 'webjump)

;; packages
(global-set-key (kbd "C-<f6>") 'package-list-packages)

;; anything
(global-set-key (kbd "C-x C-b") 'helm-for-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; compile
(global-set-key (kbd "C-c k") 'compile)

;; ctl-z binding map
(define-prefix-command 'ctl-z-map)
(global-set-key (kbd "C-z") ctl-z-map)
(define-key ctl-z-map (kbd "C-z") 'eshell)
(define-key ctl-z-map (kbd "C-1") 'display-fill-screen)
(define-key ctl-z-map (kbd "C-2") 'display-left-half)
(define-key ctl-z-map (kbd "C-3") 'display-right-half)

(provide 'personal-bindings)
