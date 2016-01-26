;;; -*- lexical-binding: t -*-

(p-require-package 'wgrep 'melpa)
(p-require-package 'wgrep-ag 'melpa)
(p-require-package 'ag)

(require 'p-leader)

(with-eval-after-load 'ag
  (setq ag-highlight-search t)
  (define-key ag-mode-map (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode))

(p-set-leader-key
  "a" 'ag-project
  "A" 'ag-project-regexp)

(provide 'p-ag)

;;; p-ag.el ends here
