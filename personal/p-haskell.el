;;; -*- lexical-binding: t -*-

(p-require-package 'haskell-mode)
(p-require-package 'ghc)
(p-require-package 'company-ghc)

(add-hook 'haskell-mode-hook #'p-set-up-haskell-mode)

(defun p-set-up-haskell-mode ()
  (turn-on-haskell-indentation)
  (ghc-init)
  (setq-local company-backends (cons 'company-ghc company-backends)))

(provide 'p-haskell)
