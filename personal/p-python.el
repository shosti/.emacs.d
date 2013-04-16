;;; -*- lexical-binding: t -*-

(p-require-package 'jedi 'melpa)

(defun set-up-python-mode ()
  (local-set-key (kbd "RET") 'p-py-newline-and-indent))

(add-hook 'python-mode-hook 'set-up-python-mode)

(defun p-py-newline-and-indent ()
  (interactive)
  (if (bolp)
      (newline)
    (newline-and-indent)))

(setq jedi:setup-keys t)
(add-hook 'python-mode-hook 'jedi:setup)

(provide 'p-python)
