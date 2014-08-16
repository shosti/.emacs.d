(p-require-package 'company)

;; No point autoloading since it's enabled globally
(require 'company)

(setq company-idle-delay 0
      company-require-match nil)

(add-hook 'after-init-hook 'global-company-mode)

;; Use control for all special keys, and make company non-intrusive
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-w") nil)
(define-key company-active-map (kbd "C-d") 'company-show-location)
(define-key company-active-map (kbd "C-RET") 'company-complete-selection)
(define-key company-active-map [C-return] 'company-complete-selection)
(define-key company-active-map (kbd "RET") nil)
(define-key company-active-map [return] nil)
(-dotimes 10
  (lambda (i)
    (define-key company-active-map (vector (+ (aref (kbd "M-0") 0) i)) nil)
    (define-key company-active-map (vector (+ (aref (kbd "C-0") 0) i))
      `(lambda ()
         (interactive)
         (company-complete-number ,(if (zerop i) 10 i))))))

(setq company-global-modes
      '(not eshell-mode))

(provide 'p-company)

;;; p-company.el ends here
