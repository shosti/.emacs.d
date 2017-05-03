;;; -*- lexical-binding: t -*-

(require 'p-bindings)

(with-eval-after-load 'shell
  (add-to-list 'explicit-bash-args "--login"))

(global-set-key (kbd "C-z C-t") 'ansi-term)

(defun p-set-up-shell-script-mode ()
  (flycheck-mode 1))

(add-hook 'sh-mode-hook #'p-set-up-shell-script-mode)

(provide 'p-shell)
