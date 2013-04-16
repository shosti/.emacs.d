;;; -*- lexical-binding: t -*-

(p-require-package 'ace-jump-mode)

(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key (kbd "C-c C-SPC") 'ace-jump-mode)

(provide 'p-ace-jump)
