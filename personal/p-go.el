(require 'p-company)

(p-require-package 'go-mode)
(p-require-package 'company-go 'melpa)
(p-require-package 'go-eldoc)
(p-require-package 'go-scratch)

(defun p-godoc-at-point ()
  (interactive)
  (godoc-at-point (point)))

(defun p-go-test ()
  (interactive)
  (compile "godep go test -v"))

(defun p-set-up-go ()
  (setq-local before-save-hook '(gofmt))
  (setq-local tab-width 4)
  (setq-local evil-lookup-func #'p-godoc-at-point)
  (setq-local p-test-runner #'p-go-test)
  (company-mode-on)
  (when buffer-file-name
    (flycheck-mode 1)
    (setq-local company-backends '(company-go)))
  (electric-pair-mode 1))

(add-hook 'go-mode-hook #'p-set-up-go)

(setq gofmt-command "goimports")

(with-eval-after-load 'go-mode
  (define-key go-mode-map (kbd "M-.") #'godef-jump)
  (define-key go-mode-map (kbd "M-,") #'pop-tag-mark))

(provide 'p-go)
;; p-go.el ends here
