;;; -*- lexical-binding: t -*-

(require 'p-bindings)
(require 'p-leader)

(global-set-key (kbd "C-z C-t") 'ansi-term)

(defun p-set-up-shell-script-mode ()
  (flycheck-mode 1))

(add-hook 'sh-mode-hook #'p-set-up-shell-script-mode)

(p-set-leader-key
  "z" 'shell)

(provide 'p-shell)
