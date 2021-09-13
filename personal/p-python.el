;;; -*- lexical-binding: t -*-

(require 'p-evil)

(add-to-list 'evil-motion-state-modes 'ein:notebooklist-mode)

(defun p-set-up-python-mode ()
  (electric-indent-mode 0))

(defun p-py-newline-and-indent ()
  (interactive)
  (if (bolp)
      (newline)
    (newline-and-indent)))

(with-eval-after-load 'python-mode
  (add-hook 'python-mode-hook 'p-set-up-python-mode)
  (define-key python-mode-map (kbd "RET") 'p-py-newline-and-indent))

(provide 'p-python)
