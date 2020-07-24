(require 'p-company)
(require 'p-evil)

(p-require-package 'go-mode 'melpa)
(p-require-package 'company-go 'melpa)
(p-require-package 'go-eldoc)
(p-require-package 'go-scratch)

(defun p-go-test ()
  (interactive)
  (compile "godep go test -v"))

(defun p-set-up-go ()
  (setq-local before-save-hook '(gofmt))
  (setq-local tab-width 4)
  (setq-local p-test-runner #'p-go-test)
  (company-mode-on)
  (when buffer-file-name
    (flycheck-mode 1)
    (setq-local company-backends '(company-go)))
  (electric-pair-mode 1))

(add-hook 'go-mode-hook #'p-set-up-go)

(setq gofmt-command "goimports")

(with-eval-after-load 'go-mode
  (add-to-list 'evil-motion-state-modes 'godoc-mode)
  (define-key go-mode-map (kbd "M-.") #'godef-jump)
  (evil-define-key 'motion go-mode-map (kbd "K") #'godoc-at-point)
  (define-key go-mode-map (kbd "M-,") #'pop-tag-mark))

(with-eval-after-load 'markdown-mode
  (add-to-list 'markdown-code-lang-modes
               '("go" . go-mode)))

(provide 'p-go)
;; p-go.el ends here
