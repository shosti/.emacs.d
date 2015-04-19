(defun p-heroku-comint (cmd &optional name)
  (interactive "sCommand: ")
  (let ((buffer (apply 'wacs-make-comint (or name "heroku") "heroku" nil
                       (s-split " +" cmd))))
    (switch-to-buffer buffer)
    (setq-local comint-process-echoes t)
    (setq-local face-remapping-alist
                '((minibuffer-prompt . ((t (:foreground "#de935f"))))))))


(provide 'p-heroku)

;;; p-heroku.el ends here
