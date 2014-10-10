;;; -*- lexical-binding: t -*-

(p-require-package 'clojure-mode)
(p-require-package 'slamhound)
(p-require-package 'cider)
(p-require-package 'clojure-cheatsheet)
(p-require-package 'request 'melpa)
(p-require-package '4clojure 'melpa)

(require 'p-functions)
(require 'p-lisp)
(require 'p-evil)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(p-configure-feature cider
  (define-key cider-test-report-mode-map "q" 'other-window)
  (font-lock-add-keywords
   'nrepl-mode
   '(("(\\|)\\|\\[\\|\\]\\|{\\|}" . 'p-paren-face))))

(p-configure-feature clojure-mode
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
(p-configure-feature cider-repl
  (defun cider-repl--show-maximum-output ()))

(provide 'p-clojure)

;;; p-clojure.el ends here
