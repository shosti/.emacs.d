;;; -*- lexical-binding: t -*-

(p-require-package 'magit 'melpa)
(p-require-package 'git-commit-mode)
(p-require-package 'gitconfig-mode)
(p-require-package 'gitignore-mode)
(p-require-package 'git-gutter 'melpa)

(eval-after-load 'magit
  '(progn
     (defadvice magit-status (around magit-fullscreen activate)
       (window-configuration-to-register :magit-fullscreen)
       ad-do-it
       (delete-other-windows))

     (defun p-magit-quit-session ()
       "Restores the previous window configuration and kills the magit buffer"
       (interactive)
       (kill-buffer)
       (jump-to-register :magit-fullscreen)
       (git-gutter))

     (defun p-magit-toggle-whitespace ()
       (interactive)
       (if (member "-w" magit-diff-options)
           (p-magit-dont-ignore-whitespace)
         (p-magit-ignore-whitespace)))

     (defun p-magit-ignore-whitespace ()
       (interactive)
       (add-to-list 'magit-diff-options "-w")
       (magit-refresh))

     (defun p-magit-dont-ignore-whitespace ()
       (interactive)
       (setq magit-diff-options (remove "-w" magit-diff-options))
       (magit-refresh))

     (define-key magit-status-mode-map (kbd "q") 'p-magit-quit-session)
     (define-key magit-status-mode-map (kbd "W") 'p-magit-toggle-whitespace)))

(global-git-gutter-mode 1)

(setq git-gutter:update-hooks '(after-save-hook after-revert-hook))
(setq git-gutter:disabled-modes '(ediff-mode))

(global-set-key (kbd "C-c g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x v p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x v n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

(provide 'p-git)

;;; p-git.el ends here
