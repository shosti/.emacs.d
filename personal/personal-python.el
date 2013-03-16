(defun set-up-python-mode ()
  (local-set-key (kbd "RET") 'personal-py-newline-and-indent))

(add-hook 'python-mode-hook 'set-up-python-mode)

(defun personal-py-newline-and-indent ()
  (interactive)
  (if (bolp)
      (newline)
    (newline-and-indent)))

(provide 'personal-python)
