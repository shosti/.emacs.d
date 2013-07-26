(p-require-package 'smartparens)

(require 'smartparens-config)

(setq sp-highlight-wrap-overlay nil
      sp-highlight-pair-overlay nil
      sp-highlight-wrap-tag-overlay nil
      sp-base-key-bindings 'paredit)

(smartparens-global-mode 1)

(provide 'p-smartparens)

;;; p-smartparens.el ends here
