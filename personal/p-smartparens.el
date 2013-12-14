(p-require-package 'smartparens)

(require 'smartparens-config)

(setq sp-highlight-wrap-overlay nil
      sp-highlight-pair-overlay nil
      sp-highlight-wrap-tag-overlay nil
      sp-base-key-bindings 'paredit)

(defun p-smartparens-hook ()
  (smartparens-mode 1))

(add-hook 'prog-mode-hook 'p-smartparens-hook)

(provide 'p-smartparens)

;;; p-smartparens.el ends here
