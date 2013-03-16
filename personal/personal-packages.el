;;; -*- lexical-binding: t -*-

(require 'package)

(setq package-archives
      (append package-archives
              '(("marmalade" . "http://marmalade-repo.org/packages/")
                ("melpa" . "http://melpa.milkbox.net/packages/"))))

(package-initialize)

;; install melpa package
(unless (package-installed-p 'melpa)
  (progn
    (switch-to-buffer
     (url-retrieve-synchronously
      "https://raw.github.com/milkypostman/melpa/master/melpa.el"))
    (package-install-from-buffer  (package-buffer-info) 'single)))

(defvar personal-stable-packages
  '(starter-kit
    starter-kit-bindings
    starter-kit-eshell
    starter-kit-js
    starter-kit-ruby
    starter-kit-lisp
    ace-jump-mode
    ack-and-a-half
    bitlbee
    c-eldoc
    clojure-mode
    coffee-mode
    dirtrack
    haskell-mode
    highlight-parentheses
    nrepl
    multiple-cursors
    undo-tree
    yaml-mode
    ;; ascope
    ;; bitlbee
    ;; buffer-move
    ;; 
    ;; coffee-mode
    ;; 
    ;; elscreen
    ;; gnuplot
    ;; google-c-style
    ;; google-contacts
    ;; jedi
    ;; jinja2-mode
    ;; yaml-mode
    ;; multiple-cursors
    )
  "A list of packages that should be installed from stable repos")

(defvar personal-melpa-packages
  '(auto-complete
    helm
    edit-server
    google-c-style
    pretty-mode
    yasnippet)
  "A list of packages that should be installed from melpa")

;; Don't get stable packages from melpa
(setq package-filter-function
      (lambda (package version archive)
        (or (not (string-equal archive "melpa"))
            (memq package personal-melpa-packages))))

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p (append personal-stable-packages personal-melpa-packages))
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'personal-packages)
