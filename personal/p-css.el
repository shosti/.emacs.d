;;; -*- lexical-binding: t -*-

(p-require-package 'scss-mode)

(setq scss-compile-at-save nil)

(eval-after-load 'scss-mode
  '(progn
     (define-key scss-mode-map (kbd "RET") 'newline-and-indent)
     (add-to-list 'ac-modes 'scss-mode)))

(provide 'p-css)
