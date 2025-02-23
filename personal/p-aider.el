(unless (package-installed-p 'aider)
  (package-vc-install '(aider :url "git@github.com:tninja/aider.el")))

(provide 'p-aider)

;;; p-aider.el ends here
