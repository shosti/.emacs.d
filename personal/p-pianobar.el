;;; -*- lexical-binding: t -*-

(autoload 'pianobar "pianobar" nil t)

(require 'p-leader)

(with-eval-after-load 'pianobar
  (setq pianobar-username "emanuel.evans@gmail.com"
        pianobar-password (password-store-get "Personal/pandora"))

  (defun pianobar-make-modeline () nil)

  (defun p-send-to-pianobar ()
    (interactive)
    (pianobar-send-command (read-char))))

(provide 'p-pianobar)

;;; p-pianobar.el ends here
