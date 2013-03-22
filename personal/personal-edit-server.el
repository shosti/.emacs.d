;;; -*- lexical-binding: t -*-

(personal-require-package 'edit-server 'melpa)

(require 'edit-server)
(setq edit-server-new-frame nil)
(edit-server-start)

(provide 'personal-edit-server)
