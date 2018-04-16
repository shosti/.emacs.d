;;; -*- lexical-binding: t -*-

(defun set-up-cc-mode ()
  (electric-indent-mode 1)
  (c-toggle-auto-hungry-state 1)
  (c-toggle-auto-newline 0))

(with-eval-after-load 'cc-mode
  (setq indent-tabs-mode nil
        c-basic-offset 4)
  (add-hook 'c-mode-common-hook 'set-up-cc-mode))

(provide 'p-cc-mode)

;;; p-cc-mode.el ends here
