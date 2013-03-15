;;; -*- lexical-binding: t -*-

(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar personal-packages
  '(starter-kit
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
  "A list of packages that should be installed")

(dolist (p personal-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'personal-packages)
