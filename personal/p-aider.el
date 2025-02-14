(unless (package-installed-p 'aider)
  (package-vc-install '(aider :url "https://github.com/tninja/aider.el")))

;; (setq aider-args
;;       '("--model" "anthropic/claude-3-5-sonnet-20241022"))

(with-eval-after-load 'aider
  (require 'aider-helm))

(global-set-key (kbd "C-c a") 'aider-transient-menu)

(provide 'p-aider)

;;; p-aider.el ends here
