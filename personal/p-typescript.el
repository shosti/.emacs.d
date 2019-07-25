;;; -*- lexical-binding: t -*-
(p-require-package 'tide 'melpa)
(p-require-package 'ts-comint 'melpa)
(p-require-package 'typescript-mode 'melpa)

(defun p-setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(defun p-set-up-web-mode-tsx ()
  (when (string-equal "tsx" (file-name-extension buffer-file-name))
    (setup-tide-mode)))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

(with-eval-after-load 'web-mode
  (add-hook 'web-mode-hook #'p-set-up-web-mode-tsx)
  (flycheck-add-mode 'typescript-tslint 'web-mode))

(with-eval-after-load 'typescript-mode
  (add-hook 'typescript-mode-hook #'p-setup-tide-mode))

;; formats the buffer before saving
(with-eval-after-load 'tide
  (add-hook 'before-save-hook #'tide-format-before-save))

(provide 'p-typescript)

;;; p-typescript.el ends here
