;;; -*- lexical-binding: t -*-

(p-require-package 'coffee-mode)

(p-configure-feature coffee-mode
  (setq coffee-tab-width 2)
  (define-key coffee-mode-map (kbd "C-c C-k") 'coffee-compile-file))

(defun set-up-coffee-mode ()
  (run-hooks 'prog-mode-hook)
  (setq coffee-command "coffee"))

(add-hook 'coffee-mode-hook
          'set-up-coffee-mode)

(add-hook 'comint-mode-hook
          #'(lambda ()
              (if (equal (buffer-name) "*CoffeeREPL*")
                  (setq comint-process-echoes t))))

(add-to-list 'auto-mode-alist '("\\.csjx\\'" . coffee-mode))

(provide 'p-coffee)
