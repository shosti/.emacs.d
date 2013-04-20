(require 'parenface)

(defun set-up-lisp-coding ()
  (show-paren-mode 0)
  (rainbow-delimiters-mode 0)
  (highlight-parentheses-mode 1)
  (local-set-key (kbd "RET") 'paredit-newline))

(add-hook 'prelude-lisp-coding-hook 'set-up-lisp-coding t)

;; Add parenface to Clojure
(add-hook 'clojure-mode-hook
          '(lambda ()
             (font-lock-add-keywords nil
                                     '(("(\\|)\\|\\[\\|\\]\\|{\\|}" . 'paren-face)))))

(defun set-up-emacs-lisp-mode ()
  (elisp-slime-nav-mode 1))

(add-hook 'emacs-lisp-mode-hook 'set-up-emacs-lisp-mode)

(provide 'personal-lisp)
