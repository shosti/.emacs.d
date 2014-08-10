(p-configure-feature diff-mode
  (--each '("M-o" "M-1" "M-2" "M-3" "M-0")
    (define-key diff-mode-map (kbd it) nil)))

(provide 'p-diff-mode)

;;; p-diff-mode.el ends here
