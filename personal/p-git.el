;;; -*- lexical-binding: t -*-

(p-require-package 'magit 'melpa)
(p-require-package 'git-rebase-mode 'melpa)
(p-require-package 'git-commit-mode 'melpa)
(p-require-package 'gitconfig-mode)
(p-require-package 'gitignore-mode)
(p-require-package 'git-gutter 'melpa)
(p-require-package 'git-gutter-fringe 'melpa)

(require 'p-evil)
(require 'git-gutter-fringe)

(defun p-insert-git-cd-number ()
  (-when-let (project-number
              (car (s-match "CD-[0-9]+"
                            (shell-command-to-string
                             "git symbolic-ref --short HEAD"))))
    (when (and (bolp) (eolp)) (insert project-number " "))))

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

     (add-hook 'git-commit-mode-hook 'p-insert-git-cd-number)

     (define-key magit-status-mode-map (kbd "q") 'p-magit-quit-session)
     (define-key magit-status-mode-map (kbd "W") 'p-magit-toggle-whitespace)
     (--each (list magit-status-mode-map magit-log-mode-map)
       (define-key it "j" 'magit-goto-next-section)
       (define-key it "k" 'magit-goto-previous-section)
       (define-key it "K" 'magit-discard-item))))

(global-git-gutter-mode 1)

(setq git-gutter:update-hooks '(after-save-hook after-revert-hook))
(setq git-gutter:disabled-modes '(ediff-mode))

(global-set-key (kbd "C-c g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x v p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x v n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

(add-to-list 'evil-emacs-state-modes 'git-rebase-mode)
(evil-add-hjkl-bindings git-rebase-mode-map)

(provide 'p-git)

;;; p-git.el ends here
