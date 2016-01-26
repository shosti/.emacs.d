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

;; Ripped from https://github.com/syl20bnr/spacemacs/pull/3319/files
(defun p-magit-full-screen (buffer)
  (if (or
       ;; the original should stay alive, so we can't go fullscreen
       magit-display-buffer-noselect
       ;; don't go fullscreen for certain magit buffers if current
       ;; buffer is a magit buffer (we're conforming to
       ;; `magit-display-buffer-traditional')
       (and (derived-mode-p 'magit-mode)
            (not (memq (with-current-buffer buffer major-mode)
                       '(magit-process-mode
                         magit-revision-mode
                         magit-diff-mode
                         magit-stash-mode
                         magit-status-mode)))))
      ;; open buffer according to original magit rules
      (magit-display-buffer-traditional buffer)
    ;; open buffer in fullscreen
    (delete-other-windows)
    ;; make sure the window isn't dedicated, otherwise
    ;; `set-window-buffer' throws an error
    (set-window-dedicated-p nil nil)
    (set-window-buffer nil buffer)
    ;; return buffer's window
    (get-buffer-window buffer)))

(setq magit-display-buffer-function #'p-magit-full-screen
      magit-completing-read-function #'magit-ido-completing-read
      magit-branch-arguments nil
      magit-push-always-verify nil)

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
          magit-revision-mode))
  ;; For some reason this isn't happening automatically 😞
  (global-git-commit-mode 1))

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
