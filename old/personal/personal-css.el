(defun set-up-css-mode ()
  (set-up-programming)
  (set-up-auto-indent))

(add-hook 'css-mode-hook 'set-up-css-mode)
(add-hook 'scss-mode-hook 'set-up-css-mode)
