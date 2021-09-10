;;; -*- lexical-binding: t -*-

(p-require-package 'swift-mode)
(p-require-package 'flycheck-swift)
(p-require-package 'lsp-sourcekit 'melpa)

(with-eval-after-load 'lsp-mode
  (when (eq system-type 'darwin)
    (require 'lsp-sourcekit)
    (require 'company-capf)
    (setq lsp-sourcekit-executable
          (string-trim (shell-command-to-string "xcrun --find sourcekit-lsp")))))

(defun p-set-up-swift ()
  (when (eq system-type 'darwin)))

(when (eq system-type 'darwin)
  (add-hook 'swift-mode-hook #'lsp))

(provide 'p-swift)

;;; p-swift.el ends here
