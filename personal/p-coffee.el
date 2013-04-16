;;; -*- lexical-binding: t -*-

(p-require-package 'coffee-mode)

(defun set-up-coffee-mode ()
  (run-hooks 'prog-mode-hook)
  (setq coffee-command "coffee"))

(add-hook 'coffee-mode-hook
          'set-up-coffee-mode)

(add-hook 'comint-mode-hook
          '(lambda ()
             (if (equal (buffer-name) "*CoffeeREPL*")
                 (setq comint-process-echoes t))))

(provide 'p-coffee)
