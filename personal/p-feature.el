;;; -*- lexical-binding: t -*-

(p-require-package 'feature-mode 'marmalade)

(p-configure-feature feature-mode
  (define-key feature-mode-map (kbd "RET") 'newline-and-indent))

(provide 'p-feature)
