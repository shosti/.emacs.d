(defun set-up-coffee-mode ()
  (run-hooks 'prelude-prog-mode-hook)
  (setq coffee-command "coffee"))

(add-hook 'coffee-mode-hook
          'set-up-coffee-mode)

(add-hook 'comint-mode-hook
          '(lambda ()
             (if (equal (buffer-name) "*CoffeeREPL*")
                 (setq comint-process-echoes t))))
