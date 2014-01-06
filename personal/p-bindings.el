;;; -*- lexical-binding: t -*-
;;; Miscellaneous keybindings

(require 'p-leader)

;;;;;;;;;;;;;;;;;;;;;;;
;; Window Management ;;
;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-o") 'other-window)

;;;;;;;;;;
;; Misc ;;
;;;;;;;;;;

(global-set-key (kbd "C-x C-z") 'ns-do-hide-emacs)

;;;;;;;;;;;;;
;; Compile ;;
;;;;;;;;;;;;;

(p-set-leader-key "c" 'compile)

(provide 'p-bindings)

;;; p-bindings.el ends here
