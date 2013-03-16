(defun set-up-inf-ruby-mode ()
  (setq comint-process-echoes t))

(add-hook 'inf-ruby-mode-hook
          'set-up-inf-ruby-mode)

(provide 'personal-ruby)
