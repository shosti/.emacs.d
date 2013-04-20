(require 'personal-packages)

(defun set-up-jinja2-mode ()
  (set-up-programming)
  (set-up-auto-indent))

(add-hook 'jinja2-mode-hook 'set-up-jinja2-mode)
