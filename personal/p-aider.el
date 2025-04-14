(unless (package-installed-p 'aider)
  (package-vc-install '(aider :url "git@github.com:tninja/aider.el")))

(with-eval-after-load 'aider
  (setq aider-args nil)
  (require 'aider-helm))

(global-set-key (kbd "C-c a") 'aider-transient-menu)

(provide 'p-aider)

;;; p-aider.el ends here
