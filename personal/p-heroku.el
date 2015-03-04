(defun p-heroku-comint (cmd)
  (interactive "sCommand: ")
  (let ((buffer (apply 'wacs-make-comint "heroku" "heroku" nil
                       (s-split " +" cmd))))
    (switch-to-buffer buffer)
    (setq-local comint-process-echoes t)))


(provide 'p-heroku)

;;; p-heroku.el ends here
