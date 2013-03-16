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
    auto-complete
    ;; ac-slime
    ;; ace-jump-mode
    ;; ascope
    ;; auto-complete
    ;; bitlbee
    ;; buffer-move
    ;; c-eldoc
    ;; coffee-mode
    ;; edit-server
    ;; elisp-slime-nav
    ;; elscreen
    ;; gnuplot
    ;; google-c-style
    ;; google-contacts
    ;; highlight-parentheses
    ;; jedi
    ;; jinja2-mode
    ;; js-comint
    ;; parenface
    ;; pretty-mode
    ;; slime-ritz
    ;; smex
    ;; undo-tree
    ;; yaml-mode
    ;; multiple-cursors
    )
  "A list of packages that should be installed from stable repos")

(defvar personal-melpa-packages
  '(helm)
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
