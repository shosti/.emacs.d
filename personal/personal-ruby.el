(defun set-up-inf-ruby-mode ()
  (setq comint-process-echoes t))

;; workaround bug in esk-ruby
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

(add-hook 'inf-ruby-mode-hook
          'set-up-inf-ruby-mode)

(provide 'personal-ruby)
