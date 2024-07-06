;;; -*- lexical-binding: t -*-

(require 'p-evil)

(p-require-package 'jsonrpc 'gnu)
(p-require-package 'eglot 'gnu)

(defun p-set-up-eglot ()
  ;; Get eldoc and flymake working together in harmony
  (setq-local eldoc-documentation-strategy #'eldoc-documentation-compose)
  (idle-highlight-mode 0))

(with-eval-after-load 'eglot
  (add-hook 'eglot-managed-mode-hook #'p-set-up-eglot)
  (setq eglot-events-buffer-size 0)
  ;; Hopefully this will speed things up?
  (fset #'jsonrpc--log-event #'ignore)
  (define-key eglot-mode-map (kbd "C-c C-l") #'eglot-code-actions)
  (p-set-leader-key "r" #'eglot-rename))

(provide 'p-eglot)

;;; p-eglot.el ends here
