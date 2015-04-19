(p-require-package 'go-mode)

(defun p-set-up-go ()
  (setq-local before-save-hook '(gofmt))
  (setq-local tab-width 4))

(add-hook 'go-mode-hook #'p-set-up-go)

(provide 'p-go)
;; p-go.el ends here
