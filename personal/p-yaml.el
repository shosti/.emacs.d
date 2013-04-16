;;; -*- lexical-binding: t -*-

(p-require-package 'yaml-mode)

(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(provide 'p-yaml)
