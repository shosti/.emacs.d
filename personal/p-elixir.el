(p-require-package 'elixir-mode)
(p-require-package 'alchemist)
(p-require-package 'ac-alchemist)
(p-require-package 'ob-elixir 'melpa)

(require 'p-evil)

(defconst p-elixir-symbols
  '(("->" . ?→)
    ("<-" . ?←)
    ("fn" . ?λ)
    ("nil" . ?∅)))

(add-to-list 'auto-mode-alist
             '("\\.eex\\'" . web-mode))

(defun p-set-up-elixir ()
  (seq-each (lambda (sym)
              (push sym prettify-symbols-alist))
            p-elixir-symbols)
  (prettify-symbols-mode 1)
  (p-config-elixir-end-mode)
  (setq-local evil-lookup-func #'alchemist-help-search-at-point))

(with-eval-after-load 'elixir-mode
  (add-hook 'elixir-mode-hook #'p-set-up-elixir)
  (add-hook 'elixir-mode-hook #'alchemist-mode)
  (add-hook 'alchemist-help-minor-mode-hook #'evil-motion-state)
  (add-hook 'alchemist-macroexpand-mode-hook #'evil-motion-state)
  (seq-each (lambda (mode)
              (add-to-list 'evil-motion-state-modes mode))
            '(alchemist-test-report-mode)))

(setq alchemist-key-command-prefix (kbd "C-c C-a"))

(defun p-config-elixir-end-mode ()
  (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
       "\\(?:^\\|\\s-+\\)\\(?:do\\)")
  (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
  (ruby-end-mode +1))

(provide 'p-elixir)

;;; p-elixir.el ends here
