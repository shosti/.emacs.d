(require 'personal-packages)

(defun set-up-ruby-mode ()
  (set-up-auto-indent))

(add-hook 'ruby-mode-hook
          'set-up-ruby-mode)

(defun set-up-inf-ruby-mode ()
  (setq comint-process-echoes t))

(add-hook 'inf-ruby-mode-hook
          'set-up-inf-ruby-mode)
