;;; -*- lexical-binding: t -*-

(p-require-package 'edit-server)

(require 'edit-server)
(setq edit-server-new-frame nil)
(setq edit-server-default-major-mode 'markdown-mode)

(provide 'p-edit-server)
