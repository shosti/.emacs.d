(require 'personal-packages)

(defun set-up-yaml-mode ()
  (set-up-programming)
  (set-up-auto-indent))

(add-hook 'yaml-mode-hook 'set-up-yaml-mode)

(add-to-list 'auto-mode-alist
             '("\\.ya?ml$" . yaml-mode))
