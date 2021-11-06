(p-require-package 'rust-mode 'melpa)
(p-require-package 'toml-mode 'melpa)

(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

;; sadly rustfmt seems a bit buggy...
(setq rust-format-on-save nil)

(provide 'p-rust)

;; p-rust.el ends here
