;;; -*- lexical-binding: t -*-

(p-require-package 'less-css-mode)
(p-require-package 'scss-mode)

(setq scss-compile-at-save nil)

(eval-after-load 'scss-mode
  '(progn
     (define-key scss-mode-map (kbd "RET") 'newline-and-indent)))

(provide 'p-css)
