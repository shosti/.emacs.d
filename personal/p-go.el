(p-require-package 'go-mode)

(defun p-godoc-at-point ()
  (interactive)
  (godoc-at-point (point)))

(defun p-set-up-go ()
  (setq-local before-save-hook '(gofmt))
  (setq-local tab-width 4)
  (setq-local evil-lookup-func #'p-godoc-at-point))

(add-hook 'go-mode-hook #'p-set-up-go)

(setq gofmt-command "goimports")

(provide 'p-go)
;; p-go.el ends here
