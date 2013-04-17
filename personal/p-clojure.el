;;; -*- lexical-binding: t -*-

(p-require-package 'clojure-mode)
(p-require-package 'nrepl)
(p-require-package 'ac-nrepl)
(p-require-package 'lein 'melpa)

(require 'clojure-mode)

(defun open-clojure-docs ()
  (interactive)
  (browse-url "http://clojure.github.com"))

(define-key clojure-mode-map "\C-c\C-dr" 'open-clojure-docs)

(require 'p-functions)
(defun drawbridge-connect (url user passwd)
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

(defun set-up-clojure-mode ()
  (setq resize-mini-windows nil))

(add-hook 'clojure-mode-hook
          'set-up-clojure-mode)

(provide 'p-clojure)

;;; p-clojure.el ends here
