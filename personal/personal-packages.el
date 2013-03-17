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
    diminish
    dirtrack
    haskell-mode
    highlight-parentheses
    js-comint
    nrepl
    multiple-cursors
    undo-tree
    yaml-mode
    )
  "A list of packages that should be installed from stable repos")

(defvar personal-melpa-packages
  '(auto-complete
    expand-region
    helm
    edit-server
    git-gutter
    google-c-style
    jedi
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
