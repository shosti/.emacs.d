(p-require-package 'rust-mode 'melpa)
(p-require-package 'toml-mode 'melpa)

(require 'p-evil)

(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

(setq ;; sadly rustfmt seems a bit buggy...
      rust-format-on-save nil)

(provide 'p-rust)

;; p-rust.el ends here
