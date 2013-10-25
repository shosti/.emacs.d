(p-require-package 'ag 'melpa)

(setq ag-highlight-search t)

(global-set-key (kbd "C-c a") 'ag-project)
(global-set-key (kbd "C-c A") 'ag-project-regexp)

(provide 'p-ag)

;;; p-ag.el ends here
