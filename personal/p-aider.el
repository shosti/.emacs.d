(unless (package-installed-p 'aider)
  (package-vc-install '(aider :url "https://github.com/tninja/aider.el")))

(setq aider-args nil)

(with-eval-after-load 'aider
  (require 'aider-helm))

(global-set-key (kbd "C-c a") 'aider-transient-menu)

(provide 'p-aider)

;;; p-aider.el ends here
