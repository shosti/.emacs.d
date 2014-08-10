;;; -*- lexical-binding: t -*-

(autoload 'pianobar "pianobar" nil t)

(require 'p-leader)

(p-configure-feature pianobar
  (setq pianobar-username "emanuel.evans@gmail.com"
        pianobar-password (p-password "Personal/pandora"))

  (defun pianobar-make-modeline () nil)

  (defun p-send-to-pianobar ()
    (interactive)
    (pianobar-send-command (read-char)))

  (p-set-leader-key "P" 'p-send-to-pianobar))

(provide 'p-pianobar)

;;; p-pianobar.el ends here
