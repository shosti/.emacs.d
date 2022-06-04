;;; -*- lexical-binding: t -*-

(p-require-package 'jsonrpc 'gnu)
(p-require-package 'eglot 'gnu)

(defun p-set-up-eglot ()
  ;; Get eldoc and flymake working together in harmony
  (setq-local eldoc-documentation-strategy #'eldoc-documentation-compose))

(with-eval-after-load 'eglot
  (add-hook 'eglot-managed-mode-hook #'p-set-up-eglot))

(provide 'p-eglot)

;;; p-eglot.el ends here
