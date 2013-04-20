(require 'personal-packages)

(defun set-up-programming ()
  (linum-mode 1)
  (whitespace-mode 0)
  (guru-mode 0)
  (local-set-key (kbd "<C-return>") 'my-move-line-down))

(add-hook 'prelude-prog-mode-hook 'set-up-programming t)

(global-undo-tree-mode 1)
(global-visual-line-mode 1)

(defun set-up-auto-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))
