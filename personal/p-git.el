;;; -*- lexical-binding: t -*-

(p-require-package 'magit 'melpa)
(p-require-package 'git-commit-mode)
(p-require-package 'gitconfig-mode)
(p-require-package 'gitignore-mode)

(eval-after-load 'magit
  '(progn
     (defadvice magit-status (around magit-fullscreen activate)
       (window-configuration-to-register :magit-fullscreen)
       ad-do-it
       (delete-other-windows))

     (defun magit-quit-session ()
       "Restores the previous window configuration and kills the magit buffer"
       (interactive)
       (kill-buffer)
       (jump-to-register :magit-fullscreen)
       (git-gutter))

     (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)))

(provide 'p-git)

;;; p-git.el ends here
