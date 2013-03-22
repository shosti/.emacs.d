;;; -*- lexical-binding: t -*-

(personal-require-package 'git-gutter 'melpa)

(require 'git-gutter)

(global-git-gutter-mode 1)
(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)

(provide 'personal-git-gutter)
