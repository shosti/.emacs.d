;;; -*- lexical-binding: t -*-

(p-require-package 'haskell-mode)

(add-hook 'haskell-mode-hook 'p-set-up-haskell-mode)

(defun p-set-up-haskell-mode ()
  (turn-on-haskell-indentation))

(provide 'p-haskell)
