;;; -*- lexical-binding: t -*-

(p-require-package 'feature-mode 'marmalade)

(with-eval-after-load 'feature-mode
  (define-key feature-mode-map (kbd "RET") 'newline-and-indent))

(provide 'p-feature)
