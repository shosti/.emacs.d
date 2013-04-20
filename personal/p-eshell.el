;;; -*- lexical-binding: t -*-

(p-require-package 'starter-kit-eshell)
(p-require-package 'dirtrack)

(require 'eshell)
(require 'dirtrack)
(require 'p-path)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(setq eshell-scroll-to-bottom-on-input t
      eshell-cmpl-cycle-completions t
      eshell-scroll-show-maximum-output nil
      eshell-directory-name (concat user-emacs-directory "eshell/"))

(setenv "TERM" "dumb")
(setenv "EDITOR" "emacsclient")
(setenv "PAGER" "cat")
(setenv "NODE_PATH" "/usr/local/lib/node")
(setenv "CLASSPATH"
        "/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar")
(setenv "PYTHONPATH"
        "/usr/local/lib/python2.7/site-packages")

(setq eshell-visual-commands
      (append eshell-visual-commands '("mu" "sl")))

;;;;;;;;;;;
;; Hooks ;;
;;;;;;;;;;;

(defun p-set-up-eshell ()
  (setq eshell-path-env (getenv "PATH"))
  ;;hack--not sure why it doesn't actually work
  (visual-line-mode 0)
  (dirtrack-mode 1))

(add-hook 'eshell-mode-hook 'p-set-up-eshell)

(provide 'p-eshell)

;;; p-eshell.el ends here
