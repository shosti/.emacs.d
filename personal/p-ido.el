;;; -*- lexical-binding: t -*-
(p-require-package 'flx-ido)

(require 'p-leader)

(flx-ido-mode 1)

(defun p-ido-setup-keybindings ()
  (define-key ido-file-completion-map
    (kbd "~")
    (lambda ()
      (interactive)
      (if (looking-back "/")
          (insert "~/")
        (call-interactively 'self-insert-command))))
  (define-key ido-file-completion-map
    (kbd "C-w")
    'ido-delete-backward-word-updir))

(add-hook 'ido-setup-hook
          'p-ido-setup-keybindings)

(p-set-leader-key
 "k" 'ido-kill-buffer
 "f" 'ido-find-file
 "B" 'ido-switch-buffer)

(provide 'p-ido)

;;; p-ido.el ends here
