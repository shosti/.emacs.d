;;; -*- lexical-binding: t -*-

(global-undo-tree-mode 1)
(global-visual-line-mode 1)

(defun set-up-auto-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))

(defun p-set-up-prog-mode ()
  (linum-mode 1))

(add-hook 'prog-mode-hook 'p-set-up-prog-mode)

(provide 'p-programming)
