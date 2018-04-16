;;; -*- lexical-binding: t -*-

(p-require-package 'clojure-mode)
(p-require-package 'cider)

(require 'p-functions)
(require 'p-lisp)
(require 'p-evil)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(with-eval-after-load 'cider
  (define-key cider-test-report-mode-map "q" 'other-window)
  (font-lock-add-keywords
   'nrepl-mode
   '(("(\\|)\\|\\[\\|\\]\\|{\\|}" . 'p-paren-face))))

(with-eval-after-load 'clojure-mode
  (font-lock-add-keywords
   'clojure-mode
   '(("(\\|)\\|\\[\\|\\]\\|{\\|}" . 'p-paren-face)
     ("\\brun[-*a-z]*" . 'font-lock-keyword-face))))

(setq evil-motion-state-modes
      (append '(cider-docview-mode
                cider-popup-buffer-mode
                cider-stacktrace-mode)
              evil-motion-state-modes))

(defun p-set-up-clojure ()
  (setq-local evil-lookup-func 'cider-doc)
  (cider-turn-on-eldoc-mode))

(add-hook 'clojure-mode-hook 'p-set-up-clojure)

;;;;;;;;;;;;;;;;;
;; Workarounds ;;
;;;;;;;;;;;;;;;;;

;; Get rid of horrible scrolling to the bottom
(with-eval-after-load 'cider-repl
  (defun cider-repl--show-maximum-output ()))

(provide 'p-clojure)

;;; p-clojure.el ends here
