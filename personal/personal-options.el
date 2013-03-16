(setq disabled-command-function nil)

(setq dired-use-ls-dired nil)

;; editing
(global-subword-mode 1)

;; backup
(setq make-backup-files nil)
(setq auto-save-default nil)

;; file
(setq delete-by-moving-to-trash t)
(setq trash-directory (expand-file-name "~/.Trash"))

(setq comint-scroll-to-bottom-on-output t)
(setq-default major-mode 'text-mode)

;; recompile modules directory
(defun personal-kill-emacs-hook ()
  (byte-recompile-directory personal-dir 0)
  (byte-recompile-file (concat user-emacs-directory "init.el") nil 0))

(add-hook 'kill-emacs-hook 'personal-kill-emacs-hook)
(setq tetris-score-file (concat user-emacs-directory "tetris-scores"))

(provide 'personal-options)
