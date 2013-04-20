;;; -*- lexical-binding: t -*-

(p-require-package 'starter-kit-lisp)
(p-require-package 'paredit)
(p-require-package 'clojure-mode)
(p-require-package 'highlight-parentheses)
(p-require-package 'macrostep)
(p-require-package 'redshank 'melpa)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(setq redshank-install-lisp-support nil)

;;;;;;;;;;;
;; Hooks ;;
;;;;;;;;;;;

(defun p-set-up-lisp-coding ()
  (show-paren-mode 0)
  (local-set-key (kbd "RET") 'paredit-newline)
  (highlight-parentheses-mode))

(defun p-set-up-emacs-lisp-mode ()
  (redshank-mode 1))

(add-hook 'emacs-lisp-mode-hook 'p-set-up-emacs-lisp-mode)

(mapc (lambda (hook)
        (add-hook hook 'p-set-up-lisp-coding))
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

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-m") 'macrostep-expand)

(provide 'p-lisp)

;;; p-lisp.el ends here
