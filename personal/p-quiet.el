(require 'p-leader)

(define-minor-mode p-quiet-mode
  "Turn off notifications for ERC and mail."
  :lighter " shhh!" :global t
  (if p-quiet-mode
      (p-quiet-mode-on)
    (p-quiet-mode-off)))

(p-set-leader-key "q" #'p-quiet-mode)

(defun p-quiet-mode-on ()
  "Enable quiet mode."
  (when (featurep 'erc)
    (customize-set-variable 'erc-modules (delq 'track erc-modules)))
  (when display-time-mode
    (setq display-time-mail-string "")
    (display-time-mode 1))
  (message "Quiet mode enabled."))

(defun p-quiet-mode-off ()
  "Disable quiet mode."
  (when (featurep 'erc)
    (customize-set-variable 'erc-modules (cons 'track erc-modules)))
  (when display-time-mode
    (setq display-time-mail-string "✉")
    (display-time-mode 1))
  (message "Quiet mode disabled."))

(provide 'p-quiet)

;;; p-quiet.el ends here
