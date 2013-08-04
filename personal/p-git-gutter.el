;;; -*- lexical-binding: t -*-

(p-require-package 'git-gutter 'melpa)

(global-git-gutter-mode 1)

(setq git-gutter:update-hooks '(after-save-hook after-revert-hook))
(setq git-gutter:disabled-modes '(ediff-mode))

(global-set-key (kbd "C-c g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x v p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x v n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

(provide 'p-git-gutter)

;;; p-git-gutter.el ends here
