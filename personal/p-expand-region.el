;;; -*- lexical-binding: t -*-

(p-require-package 'expand-region)

(require 'expand-region)

(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'p-expand-region)
