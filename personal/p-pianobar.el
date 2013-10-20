(autoload 'pianobar "pianobar" nil t)

(eval-after-load 'pianobar
  '(progn
     (setq pianobar-username "emanuel.evans@gmail.com"
           pianobar-password (p-password 'pandora-password))

     (defun pianobar-make-modeline () nil)

     (defun p-send-to-pianobar ()
       (interactive)
       (pianobar-send-command (read-char)))

     (global-set-key (kbd "C-c b") 'p-send-to-pianobar)))

(provide 'p-pianobar)

;;; p-pianobar.el ends here
