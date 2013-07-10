;;; -*- lexical-binding: t -*-

(p-require-package 'jedi 'melpa)

(defun p-set-up-python-mode ()
  (electric-indent-mode 0)
  (local-set-key (kbd "RET") 'p-py-newline-and-indent)
  (hack-local-variables) ; necessary to get local python interpreter
  (set (make-local-variable 'jedi:server-command)
       (list python-shell-interpreter jedi:server-script)))

(defun p-py-newline-and-indent ()
  (interactive)
  (if (bolp)
      (newline)
    (newline-and-indent)))

(eval-after-load 'python-mode
  '(progn
     (setq jedi:setup-keys t)
     (add-hook 'python-mode-hook 'jedi:setup)
     (add-hook 'python-mode-hook 'p-set-up-python-mode)))

(provide 'p-python)
