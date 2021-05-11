(p-require-package 'company-emoji)
(p-require-package 'emojify)

(defun p-company-emoji-init ()
  "Turn on company mode and also set it to only do emoji."
  (company-mode-on)
  (setq-local company-backends '(company-emoji)))

(provide 'p-emoji)

;;; p-emoji.el ends here
