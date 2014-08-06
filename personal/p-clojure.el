;;; -*- lexical-binding: t -*-

(p-require-package 'clojure-mode)
(p-require-package 'slamhound)
(p-require-package 'cider)
(p-require-package 'clojure-cheatsheet)

(require 'p-functions)
(require 'p-lisp)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

(eval-after-load 'cider
  '(progn
     (setq cider-popup-stacktraces nil)
     (font-lock-add-keywords
      'nrepl-mode
      '(("(\\|)\\|\\[\\|\\]\\|{\\|}" . 'p-paren-face)))))

(eval-after-load 'clojure-mode
  '(progn
     (font-lock-add-keywords
      'clojure-mode
      '(("(\\|)\\|\\[\\|\\]\\|{\\|}" . 'p-paren-face)
        ("\\brun[-*a-z]*" . 'font-lock-keyword-face)))
     ;; Custom indentation of functions
     (define-clojure-indent
       (run* 'defun)
       (run 'defun)
       (fresh 1))))

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;

(defun p-open-clojure-docs ()
  (interactive)
  (browse-url "http://clojure.github.com"))

(defun p-drawbridge-connect (url user passwd)
  (interactive (list
                (read-from-minibuffer
                 "URL: "
                 (format "https://%s.herokuapp.com/repl"
                         (current-project-name)))
                (read-from-minibuffer "User: ")
                (read-passwd "Password: ")))
  (let* ((url-components (split-string url "://"))
         (url (car (last url-components)))
         (protocol (if (= (length url-components) 1)
                       "https"
                     (car url-components)))
         (connection-string (format "lein repl :connect %s://%s:%s@%s"
                                    protocol
                                    user
                                    passwd
                                    url)))
    (message "Connecting to drawbridge...")
    (run-lisp connection-string)))

;;;;;;;;;;;
;; Hooks ;;
;;;;;;;;;;;

(defun p-set-up-nrepl ()
  (nrepl-turn-on-eldoc-mode))

(defun p-set-up-nrepl-repl ()
  (paredit-mode 1))

(add-hook 'nrepl-interaction-mode-hook 'p-set-up-nrepl)
(add-hook 'nrepl-mode-hook 'p-set-up-nrepl)
(add-hook 'nrepl-mode-hook 'p-set-up-nrepl-repl)

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

(eval-after-load 'nrepl
  '(progn
     (define-key nrepl-interaction-mode-map
       (kbd "C-c C-c")
       'nrepl-eval-buffer)))

;;;;;;;;;;;;;;;;;
;; Workarounds ;;
;;;;;;;;;;;;;;;;;

;; I hate auto-scrolling
(eval-after-load 'nrepl
  '(progn
     (defun nrepl-show-maximum-output ())))

(provide 'p-clojure)

;;; p-clojure.el ends here
