;;; -*- lexical-binding: t -*-

(p-require-package 'less-css-mode)
(p-require-package 'scss-mode)

(setq scss-compile-at-save nil)

(with-eval-after-load 'scss-mode
  (define-key scss-mode-map (kbd "RET") 'newline-and-indent))

(provide 'p-css)
