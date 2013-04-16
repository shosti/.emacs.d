;;; -*- lexical-binding: t -*-

(p-require-package 'starter-kit-lisp)
(p-require-package 'paredit)
(p-require-package 'clojure-mode)
(p-require-package 'highlight-parentheses)

(defun set-up-lisp-coding ()
  (show-paren-mode 0)
  (local-set-key (kbd "RET") 'paredit-newline)
  (highlight-parentheses-mode))

(mapc (lambda (hook)
        (add-hook hook 'set-up-lisp-coding))
      '(emacs-lisp-mode-hook
        lisp-interaction-mode-hook
        lisp-mode-hook
        clojure-mode-hook
        scheme-mode-hook))

;; Add parenface to Clojure and lisp interaction mode
(add-hook 'clojure-mode-hook
          '(lambda ()
             (font-lock-add-keywords
              nil
              '(("(\\|)\\|\\[\\|\\]\\|{\\|}" . 'paren-face)))))

(add-hook 'lisp-interaction-mode-hook
          '(lambda ()
             (font-lock-add-keywords
              nil
              '(("(\\|)" . 'paren-face)))))

;; Keybindings
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)

(provide 'p-lisp)
