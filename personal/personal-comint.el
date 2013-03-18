(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-show-maximum-output nil)

(define-key comint-mode-map (kbd "C-a") 'comint-bol)

(provide 'personal-comint)
