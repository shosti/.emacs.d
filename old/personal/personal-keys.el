(require 'personal-packages)

;;window management
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-o") 'other-window)

;;misc
(global-set-key (kbd "C-w") 'my-backward-kill-word)
(global-set-key "\C-x\C-z" 'ns-do-hide-emacs)

;;packages
(global-set-key (kbd "C-<f6>") 'package-list-packages)

;;paredit
(require 'paredit)
(define-key paredit-mode-map "\C-w" 'my-paredit-backward-kill-word)

;;anything
(global-set-key "\C-x\C-b" 'helm-for-files)
(global-set-key "\M-y" 'helm-show-kill-ring)

;;compile
(define-key prelude-mode-map "\C-ck" 'compile)

;; miscellaneous
(global-set-key (kbd "C-M-h") 'mark-defun) ; undo prelude-mode binding
