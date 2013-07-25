(eval-after-load 'html-mode
  '(progn
     (define-key html-mode-map (kbd "RET") 'newline-and-indent)))

(eval-after-load 'mmm-erb
  '(progn
     (define-key html-erb-mode-map (kbd "RET") 'newline-and-indent)  ))

(provide 'p-html)

;;; p-html.el ends here
