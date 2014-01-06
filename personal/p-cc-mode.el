;;; -*- lexical-binding: t -*-

(p-require-package 'google-c-style 'melpa)
(p-require-package 'c-eldoc)

(defun set-up-cc-mode ()
  (google-set-c-style)
  (c-turn-on-eldoc-mode)
  (electric-indent-mode 1)
  (c-toggle-auto-hungry-state 1)
  (c-toggle-auto-newline 0))

(eval-after-load 'cc-mode
  '(progn
     (require 'google-c-style)
     (require 'c-eldoc)
     (setq indent-tabs-mode nil
           c-basic-offset 4)
     (add-hook 'c-mode-common-hook 'set-up-cc-mode)))

(provide 'p-cc-mode)

;;; p-cc-mode.el ends here
