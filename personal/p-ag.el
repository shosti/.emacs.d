(p-require-package 'ag 'melpa)

(require 'p-leader)

(setq ag-highlight-search t)

(p-set-leader-key
  "a" 'ag-project
  "A" 'ag-project-regexp)

(provide 'p-ag)

;;; p-ag.el ends here
