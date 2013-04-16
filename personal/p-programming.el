;;; -*- lexical-binding: t -*-

(p-require-package 'undo-tree)

(global-undo-tree-mode 1)
(global-visual-line-mode 1)

(defun set-up-auto-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))

(provide 'p-programming)
