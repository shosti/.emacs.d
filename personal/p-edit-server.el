;;; -*- lexical-binding: t -*-

(p-require-package 'edit-server 'melpa)

(require 'edit-server)
(setq edit-server-new-frame nil)
(edit-server-start)

(provide 'p-edit-server)
