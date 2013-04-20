(require 'personal-packages)

(defun set-up-html-mode ()
  (set-up-programming)
  (set-up-auto-indent))

(add-hook 'html-mode-hook 'set-up-html-mode)
