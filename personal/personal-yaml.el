;;; -*- lexical-binding: t -*-

(personal-require-package 'yaml-mode)

(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(provide 'personal-yaml)
