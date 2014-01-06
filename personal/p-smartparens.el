;;; -*- lexical-binding: t -*-

(p-require-package 'smartparens)

(require 'smartparens-config)

(setq sp-highlight-wrap-overlay nil
      sp-highlight-pair-overlay nil
      sp-highlight-wrap-tag-overlay nil
      sp-base-key-bindings 'paredit)

(defun p-smartparens-hook ()
  (unless paredit-mode
    (smartparens-mode 1)))

(defadvice paredit-mode (after deactivate-smartparens activate)
  (smartparens-mode 0))

(add-hook 'prog-mode-hook 'p-smartparens-hook)

(provide 'p-smartparens)

;;; p-smartparens.el ends here
