;;; -*- lexical-binding: t -*-
(p-require-package 'add-node-modules-path 'melpa)
(p-require-package 'prettier-js 'melpa)

(setq major-mode-remap-alist
      (cons '(typescript-mode . typescript-ts-mode) major-mode-remap-alist))

(use-package typescript-ts-mode
  :init
  (add-hook 'typescript-ts-mode #'p-set-up-typescript)
  (add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-ts-mode)))

(defun p-set-up-typescript ()
  (prettier-js-mode))

(provide 'p-typescript)

;;; p-typescript.el ends here
