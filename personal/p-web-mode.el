(p-require-package 'web-mode 'melpa)

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(setq web-mode-enable-auto-quoting nil
      web-mode-code-indent-offset 2)

(provide 'p-web-mode)

;;; p-web-mode.el ends here
