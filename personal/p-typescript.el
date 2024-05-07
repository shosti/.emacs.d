;;; -*- lexical-binding: t -*-
(p-require-package 'add-node-modules-path 'melpa)
(p-require-package 'prettier-js 'melpa)

(setq major-mode-remap-alist
      (cons '(typescript-mode . typescript-ts-mode) major-mode-remap-alist))

(use-package typescript-ts-mode
  :init
  (add-hook 'typescript-ts-mode #'p-set-up-typescript))

(defun p-set-up-typescript ())

(provide 'p-typescript)

;;; p-typescript.el ends here
