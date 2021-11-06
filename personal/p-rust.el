(p-require-package 'rust-mode 'melpa)
(p-require-package 'toml-mode 'melpa)

(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

;; sadly rustfmt seems a bit buggy...
(setq rust-format-on-save nil)

(defun p-set-up-rust ()
  (setq company-backends '(company-capf))
  (lsp))

(with-eval-after-load 'rust-mode
  (add-hook 'rust-mode-hook #'p-set-up-rust))

(provide 'p-rust)

;; p-rust.el ends here
