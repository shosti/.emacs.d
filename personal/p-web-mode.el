(p-require-package 'web-mode)

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(defun p-set-up-web-mode ()
  (smartparens-mode 0))

(add-hook 'web-mode-hook 'p-set-up-web-mode)

(provide 'p-web-mode)

;;; p-web-mode.el ends here
