;;; -*- lexical-binding: t -*-

(p-require-package 'idle-highlight-mode)
(p-require-package 'nlinum 'gnu)

(require 'saveplace)

(global-undo-tree-mode 1)
(global-visual-line-mode 1)

;; Mostly stolen from ESK
(setq whitespace-style '(face trailing lines-tail)
      whitespace-line-column 100)

(defun p-add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIXME\\|TODO\\|FIX\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
          1 font-lock-warning-face t))))

(defun p-prog-mode-hook ()
  (run-hooks 'prog-mode-hook))

(defun p-set-up-prog-mode ()
  (column-number-mode 1)
  (nlinum-mode 1)
  (setq save-place 1)
  (when (> (display-color-cells) 8)
    (hl-line-mode 1))
  (whitespace-mode 1)
  (idle-highlight-mode t)
  (p-add-watchwords))

(add-hook 'prog-mode-hook 'p-set-up-prog-mode)

(provide 'p-programming)
