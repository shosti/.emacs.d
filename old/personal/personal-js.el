(require 'personal-packages)

(defun set-up-js-mode ()
  (local-set-key (kbd "RET") 'newline-and-indent))

(add-hook 'js-mode-hook 'set-up-js-mode)
