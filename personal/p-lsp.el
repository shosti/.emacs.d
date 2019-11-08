;;; -*- lexical-binding: t -*-

(require 'p-company)
(require 'p-evil)

(p-require-package 'lsp-mode)
(p-require-package 'company-lsp)

(setq lsp-prefer-flymake nil
      lsp-ui-peek-enable nil
      lsp-ui-sideline-enable nil
      lsp-ui-flycheck-enable t)

(require 'lsp)
(require 'company-lsp)

(defvar-local p-lsp-doc-showing nil)

(defun p-lsp-setup ()
  (lsp-ui-doc-mode 0)
  (lsp-ui-flycheck-enable 1))

(defun p-lsp-toggle-doc ()
  (if p-lsp-doc-showing
      (progn
        (lsp-ui-doc-hide)
        (setq p-lsp-doc-showing nil))
    (lsp-ui-doc-show)
    (setq p-lsp-doc-showing t)))

(defun p-set-up-lsp-ui ()
  (setq-local evil-lookup-func #'p-lsp-toggle-doc))

(add-hook 'lsp-after-open-hook #'p-lsp-setup)
(add-hook 'lsp-mode-hook #'lsp-ui-mode)
(add-hook 'lsp-ui-mode-hook #'p-set-up-lsp-ui)

(add-hook 'go-mode-hook #'lsp-deferred)

(provide 'p-lsp)

;;; p-lsp.el ends here
