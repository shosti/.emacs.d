(unless (package-installed-p 'eat)
  (package-vc-install '(eat :url "https://github.com/kephale/emacs-eat")))

(unless (package-installed-p 'claude-code)
  (package-vc-install '(claude-code :url "https://github.com/stevemolitor/claude-code.el")))

(require 'claude-code)
(global-set-key (kbd "C-c c") claude-code-command-map) ;; or your preferred key
(claude-code-mode)
(provide 'p-claude-code)

;;; p-claude-code.el ends here
