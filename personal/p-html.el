;;; -*- lexical-binding: t -*-

(with-eval-after-load 'html-mode
  (define-key html-mode-map (kbd "RET") 'newline-and-indent))

(with-eval-after-load 'mhtml-mode
  (define-key mhtml-mode-map (kbd "M-o") nil))

(provide 'p-html)

;;; p-html.el ends here
