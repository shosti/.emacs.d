;;; -*- lexical-binding: t -*-

(p-require-package 'git-gutter 'melpa)

(require 'git-gutter)

(global-git-gutter-mode 1)
(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)

(provide 'p-git-gutter)
