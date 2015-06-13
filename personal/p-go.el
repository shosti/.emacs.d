(require 'p-company)

(p-require-package 'go-mode)
(p-require-package 'company-go)

(defun p-godoc-at-point ()
  (interactive)
  (godoc-at-point (point)))

(defun p-set-up-go ()
  (setq-local before-save-hook '(gofmt))
  (setq-local tab-width 4)
  (setq-local evil-lookup-func #'p-godoc-at-point)
  (company-mode-on)
  (setq-local company-backends '(company-go))
  (electric-pair-mode 1))

(add-hook 'go-mode-hook #'p-set-up-go)

(setq gofmt-command "goimports")

(provide 'p-go)
;; p-go.el ends here
