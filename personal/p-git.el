;;; -*- lexical-binding: t -*-

(p-require-package 'magit)
(p-require-package 'gh)
(p-require-package 'git-rebase-mode)
(p-require-package 'git-commit-mode)
(p-require-package 'gitconfig-mode)
(p-require-package 'gitignore-mode)
(p-require-package 'git-gutter)
(p-require-package 'fringe-helper)
(p-require-package 'git-gutter-fringe)
(p-require-package 'git-timemachine)

(require 'p-evil)
(require 'p-leader)

(defun p-insert-git-cd-number ()
  (-when-let (project-number
              (car (s-match "\\(CD\\|JZ\\)-[0-9]+"
                            (shell-command-to-string
                             "git symbolic-ref --short HEAD"))))
    (when (and (bolp) (eolp)) (insert project-number " "))))

(defadvice magit-status (around magit-fullscreen activate)
  ;; <option>-g = ©
  (window-configuration-to-register ?©)
  ad-do-it
  (delete-other-windows))

(defun p-magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register ?©))

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

(p-configure-feature magit
  (magit-auto-revert-mode 0) ; just use global auto-revert-mode instead

  (p-add-hjkl-bindings magit-status-mode-map 'emacs
    "K" 'magit-discard-item
    "V" 'magit-revert-item
    "v" 'set-mark-command
    "l" 'magit-key-mode-popup-logging
    "h" 'magit-key-mode-popup-diff-options
    "q" 'p-magit-quit-session
    "W" 'p-magit-toggle-whitespace
    ":" 'magit-git-command
    (kbd "C-n") 'magit-goto-next-section
    (kbd "C-p") 'magit-goto-previous-section)

  (p-add-hjkl-bindings magit-log-mode-map 'emacs
    "V" 'magit-revert-item
    "l" 'magit-key-mode-popup-logging
    "h" 'magit-log-toggle-margin
    "/" 'evil-search-forward
    "?" 'evil-search-backward
    "n" 'evil-search-next
    "N" 'evil-search-previous
    (kbd "C-n") 'magit-goto-next-section
    (kbd "C-p") 'magit-goto-previous-section)

  (p-add-hjkl-bindings magit-commit-mode-map 'emacs
    "V" 'magit-revert-item
    "v" 'set-mark-command
    "l" 'magit-key-mode-popup-logging
    "h" 'magit-key-mode-popup-diff-options
    (kbd "C-n") 'magit-goto-next-section
    (kbd "C-p") 'magit-goto-previous-section)

  (p-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
    "K" 'magit-discard-item)

  (add-to-list 'evil-emacs-state-modes 'git-rebase-mode)
  (add-to-list 'evil-insert-state-modes 'git-commit-mode)
  (p-add-hjkl-bindings magit-blame-map)
  (p-add-hjkl-bindings git-rebase-mode-map 'emacs
    "K" 'git-rebase-kill-line))

(p-configure-feature git-gutter
  (require 'git-gutter-fringe)
  (setq git-gutter:disabled-modes '(ediff-mode)))

(add-hook 'prog-mode-hook 'git-gutter-mode)

;;;;;;;;;;;;;;
;; Bindings ;;
;;;;;;;;;;;;;;

(defadvice magit-blame-mode (after switch-to-emacs-mode activate)
  (if magit-blame-mode
      (evil-emacs-state 1)
    (evil-normal-state 1)))

(p-set-leader-key
  "m" 'magit-blame-mode
  "g" 'magit-status)

;;;;;;;;;;;
;; Hooks ;;
;;;;;;;;;;;

(add-hook 'git-commit-mode-hook 'auto-fill-mode)

(provide 'p-git)

;;; p-git.el ends here
