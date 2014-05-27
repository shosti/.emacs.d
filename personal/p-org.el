;;; -*- lexical-binding: t -*-

(setq org-startup-indented t)

(defun p-set-up-org-mode ()
  (auto-fill-mode 1)
  (flyspell-mode 1))

(add-hook 'org-mode-hook 'p-set-up-org-mode)

(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))

(provide 'p-org)
