;;; -*- lexical-binding: t -*-

(p-require-package 'lsp-mode)
(p-require-package 'lsp-ui)

(require 'p-evil)

(setq lsp-ui-doc-show-with-cursor nil)

(defun p-lsp-ui-doc-toggle ()
  (interactive)
  (if (lsp-ui-doc--visible-p)
      (lsp-ui-doc-hide)
    (lsp-ui-doc-show)))

(with-eval-after-load 'lsp-mode
  (evil-define-key 'normal lsp-mode-map "K" #'p-lsp-ui-doc-toggle))

(provide 'p-lsp)

;;; p-lsp.el ends here
