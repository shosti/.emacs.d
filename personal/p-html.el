;;; -*- lexical-binding: t -*-

(p-require-package 'slim-mode)

(with-eval-after-load 'html-mode
  (define-key html-mode-map (kbd "RET") 'newline-and-indent))

(with-eval-after-load 'mmm-erb
  (define-key html-erb-mode-map (kbd "RET") 'newline-and-indent)  )

(provide 'p-html)

;;; p-html.el ends here
