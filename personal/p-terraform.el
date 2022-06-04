;;; -*- lexical-binding: t -*-

(p-require-package 'terraform-mode)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(terraform-mode . ("terraform-ls" "serve"))))

(with-eval-after-load 'terraform-mode
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

(provide 'p-terraform)

;;; p-terraform.el ends here
