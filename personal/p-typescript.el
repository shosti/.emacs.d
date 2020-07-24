;;; -*- lexical-binding: t -*-
(p-require-package 'ts-comint 'melpa)
(p-require-package 'typescript-mode 'melpa)
(p-require-package 'add-node-modules-path 'melpa)
(p-require-package 'prettier-js 'melpa)

(defun p-set-up-web-mode-tsx ()
  (when (string-equal "tsx" (file-name-extension buffer-file-name))
    (prettier-js-mode 1)))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

(with-eval-after-load 'web-mode
  (add-hook 'web-mode-hook #'add-node-modules-path)
  (add-hook 'web-mode-hook #'p-set-up-web-mode-tsx))

(with-eval-after-load 'typescript-mode
  (add-hook 'typescript-mode-hook #'prettier-js-mode))

(provide 'p-typescript)

;;; p-typescript.el ends here
