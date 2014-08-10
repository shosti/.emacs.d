;;; -*- lexical-binding: t -*-

(p-require-package 'slim-mode)

(p-configure-feature html-mode
  (define-key html-mode-map (kbd "RET") 'newline-and-indent))

(p-configure-feature mmm-erb
  (define-key html-erb-mode-map (kbd "RET") 'newline-and-indent)  )

(provide 'p-html)

;;; p-html.el ends here
