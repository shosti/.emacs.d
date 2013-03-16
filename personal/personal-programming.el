(defun set-up-programming ()
  (whitespace-mode 0)
  (local-set-key (kbd "<C-return>") 'personal-move-line-down))

(add-hook 'prog-mode-hook 'set-up-programming t)

(global-undo-tree-mode 1)
(global-visual-line-mode 1)

(defun set-up-auto-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))

(provide 'personal-programming)
