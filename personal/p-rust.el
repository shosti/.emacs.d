(p-require-package 'rust-mode 'melpa)
(p-require-package 'rustic 'melpa)
(p-require-package 'toml-mode 'melpa)

(require 'p-evil)

(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

(use-package rust-mode
  :init
  (evil-define-key 'motion rust-mode-map (kbd "K") #'eldoc-doc-buffer)
  (add-hook 'rust-mode-hook #'p-set-up-rust))

(use-package rustic
  :custom
  (rustic-analyzer-command '("rustup" "run" "nightly" "rust-analyzer"))
  :init
  (setq rustic-lsp-client 'eglot
        rustic-babel-default-toolchain "nightly"
        rustic-default-test-arguments "--tests")
  (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1))))

(setq ;; sadly rustfmt seems a bit buggy...
 rust-format-on-save nil)

(defun p-set-up-rust ())


(provide 'p-rust)

;; p-rust.el ends here
