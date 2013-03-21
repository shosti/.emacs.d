(defun set-up-inf-ruby-mode ()
  (setq comint-process-echoes t))

;; workaround bug in esk-ruby
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

(add-hook 'inf-ruby-mode-hook
          'set-up-inf-ruby-mode)

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-c v") 'ruby-load-file)))

;; rvm
(rvm-use-default)

(provide 'personal-ruby)
