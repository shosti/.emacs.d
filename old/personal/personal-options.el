(require 'personal-packages)

;; I like my arrow keys occasionally!
(guru-mode 0)

(setq visible-bell t)
(setq disabled-command-function nil)

(setq dired-use-ls-dired nil)

;;editing
(global-subword-mode 1)

;;backup
(setq make-backup-files nil)
(setq auto-save-default nil)

;;file
(setq delete-by-moving-to-trash t)

(setq comint-scroll-to-bottom-on-output t)
(setq-default major-mode 'text-mode)

;;recompile modules directory
(add-hook 'kill-emacs-hook
          (lambda ()
            (byte-recompile-directory prelude-modules-dir)
            (byte-recompile-file (concat user-emacs-directory "init.el"))))

(setq tetris-score-file (concat user-emacs-directory "tetris-scores"))
