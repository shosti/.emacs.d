(p-require-package 'company)

(require 'company)

(setq company-idle-delay 0)

(add-hook 'after-init-hook 'global-company-mode)

(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(provide 'p-company)

;;; p-company.el ends here
