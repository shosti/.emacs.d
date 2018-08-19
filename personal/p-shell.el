;;; -*- lexical-binding: t -*-

(p-require-package 'bash-completion 'melpa)

(require 'p-bindings)
(require 'p-leader)

(with-eval-after-load 'shell
  (setq bash-completion-prog (executable-find "bash"))
  (bash-completion-setup))

(global-set-key (kbd "C-z C-t") 'ansi-term)

(defun p-set-up-shell-script-mode ()
  (flycheck-mode 1))

(add-hook 'sh-mode-hook #'p-set-up-shell-script-mode)

(p-set-leader-key
  "z" 'shell)

(provide 'p-shell)
