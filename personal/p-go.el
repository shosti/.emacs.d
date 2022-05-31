(require 'p-company)
(require 'p-evil)
(require 'p-eglot)

(p-require-package 'go-mode 'melpa)
(p-require-package 'company-go 'melpa)
(p-require-package 'go-eldoc)
(p-require-package 'go-scratch)

(defun p-set-up-go ()
  (setq-local before-save-hook '(gofmt))
  (setq-local tab-width 4)
  (company-mode-on)
  (when buffer-file-name
    (flycheck-mode 1))
  (electric-pair-mode 1))

(add-hook 'go-mode-hook #'p-set-up-go)
(add-hook 'go-mode-hook #'eglot-ensure)

(setq gofmt-command "goimports")

(with-eval-after-load 'go-mode
  (evil-define-key 'motion go-mode-map (kbd "K") #'eldoc-doc-buffer))

(with-eval-after-load 'markdown-mode
  (add-to-list 'markdown-code-lang-modes
               '("go" . go-mode)))

(provide 'p-go)
;; p-go.el ends here
