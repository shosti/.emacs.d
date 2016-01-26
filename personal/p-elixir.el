(p-require-package 'elixir-mode)
(p-require-package 'alchemist)
(p-require-package 'ac-alchemist)

(add-to-list 'auto-mode-alist
             '("\\.eex\\'" . web-mode))

(with-eval-after-load 'elixir-mode
  (add-to-list 'elixir-mode-hook #'p-config-elixir-end-mode)
  (add-to-list 'elixir-mode-hook #'alchemist-mode))

(setq alchemist-key-command-prefix (kbd "C-c C-a"))

(defun p-config-elixir-end-mode ()
  (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
       "\\(?:^\\|\\s-+\\)\\(?:do\\)")
  (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
  (ruby-end-mode +1))

(provide 'p-elixir)

;;; p-elixir.el ends here
