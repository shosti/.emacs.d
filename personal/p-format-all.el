(require 'p-leader)

(p-require-package 'format-all 'melpa)

(setq format-all-formatters
      '(("Ruby" (rubocop))))

(p-set-leader-key "F" 'format-all-region-or-buffer)

(provide 'p-format-all)

;;; p-format-all.el ends here
