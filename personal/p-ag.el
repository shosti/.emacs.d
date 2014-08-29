;;; -*- lexical-binding: t -*-

(p-require-package 'ag)

(require 'p-leader)

(p-configure-feature ag
  (setq ag-highlight-search t))

(p-set-leader-key
  "a" 'ag-project
  "A" 'ag-project-regexp)

(provide 'p-ag)

;;; p-ag.el ends here
