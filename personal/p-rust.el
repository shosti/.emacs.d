(p-require-package 'rust-mode 'melpa)
(p-require-package 'toml-mode 'melpa)

(require 'p-evil)

(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

(setq lsp-rust-analyzer-cargo-watch-command "clippy"
      lsp-rust-analyzer-proc-macro-enable t
      ;; sadly rustfmt seems a bit buggy...
      rust-format-on-save nil)

(defun p-set-up-rust ()
  (setq company-backends '(company-capf))
  (lsp))

(with-eval-after-load 'rust-mode
  (evil-define-key 'normal 'rust-mode-map "J" #'lsp-rust-analyzer-join-lines)
  (add-hook 'rust-mode-hook #'p-set-up-rust))

(provide 'p-rust)

;; p-rust.el ends here
