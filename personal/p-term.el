(with-eval-after-load 'term
  (setq explicit-shell-file-name "/bin/bash")
  (key-chord-define term-mode-map "jk" nil))

(provide 'p-term)
