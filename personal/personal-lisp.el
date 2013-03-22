;;; -*- lexical-binding: t -*-

(personal-require-package 'starter-kit-lisp)
(personal-require-package 'paredit)
(personal-require-package 'clojure-mode)
(personal-require-package 'highlight-parentheses)

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

;; Add parenface to Clojure
(add-hook 'clojure-mode-hook
          '(lambda ()
             (font-lock-add-keywords nil
                                     '(("(\\|)\\|\\[\\|\\]\\|{\\|}" . 'paren-face)))))

(provide 'personal-lisp)
