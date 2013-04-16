(p-require-package 'feature-mode)

(eval-after-load 'feature-mode
  '(progn
     (define-key feature-mode-map (kbd "RET") 'newline-and-indent)))

(provide 'p-feature)
