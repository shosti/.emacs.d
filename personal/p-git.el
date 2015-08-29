;;; -*- lexical-binding: t -*-

(p-require-package 'magit)
(p-require-package 'with-editor)
(p-require-package 'git-commit)
(p-require-package 'magit-popup)
(p-require-package 'gh)
(p-require-package 'gitconfig-mode)
(p-require-package 'gitignore-mode)
(p-require-package 'git-gutter)
(p-require-package 'fringe-helper)
(p-require-package 'git-gutter-fringe)
(p-require-package 'git-timemachine)

(require 'p-evil)
(require 'p-leader)

(defun p-magit-full-screen (buffer)
  (switch-to-buffer buffer)
  (delete-other-windows))

(setq magit-status-buffer-switch-function #'p-magit-full-screen
      magit-completing-read-function #'magit-ido-completing-read
      magit-branch-arguments nil
      magit-revert-buffers nil)

(p-configure-feature magit
  (mapc (lambda (map)
          (define-key map "j" #'evil-next-line)
          ;; idempotently remap "k" to "K"
          (let ((cur-k-cmd (lookup-key map "k")))
            (unless (eq cur-k-cmd #'evil-previous-line)
              (define-key map "K" cur-k-cmd)))
          (define-key map "k" #'evil-previous-line)
          (define-key map (kbd "C-f") #'evil-scroll-page-down)
          (define-key map (kbd "C-b") #'evil-scroll-page-up))
        (list magit-diff-mode-map
              magit-revision-mode-map
              magit-stashes-mode-map
              magit-status-mode-map
              magit-log-mode-map
              magit-stashes-section-map
              magit-stash-section-map
              magit-file-section-map
              magit-hunk-section-map
              magit-unstaged-section-map
              magit-staged-section-map
              magit-untracked-section-map
              magit-branch-section-map
              magit-remote-section-map
              magit-tag-section-map
              magit-blame-mode-map))

  (define-key magit-file-section-map (kbd "M-S-k") #'magit-file-untrack)

  (mapc (lambda (mode)
          (add-to-list 'evil-emacs-state-modes mode))
        '(magit-popup-mode
          magit-popup-sequence-mode
          magit-revision-mode)))

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
  "m" 'magit-blame
  "g" 'magit-status)

;;;;;;;;;;;
;; Hooks ;;
;;;;;;;;;;;

(defun p-set-up-git-commit-mode ()
  (auto-fill-mode 1)
  (evil-insert-state 1)
  (p-company-emoji-init))

(add-hook 'git-commit-mode-hook #'p-set-up-git-commit-mode)

(provide 'p-git)

;;; p-git.el ends here
