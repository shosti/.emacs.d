;;; -*- lexical-binding: t -*-
;;; Miscellaneous options and settings

;; Settings

(setq disabled-command-function nil)
(setq dired-use-ls-dired nil)

;; backup
(setq make-backup-files nil)
(setq auto-save-default nil)

;; file
(setq delete-by-moving-to-trash t)
(setq trash-directory (expand-file-name "~/.Trash"))

(setq comint-scroll-to-bottom-on-output t)
(setq-default major-mode 'text-mode)

(setq tetris-score-file (concat user-emacs-directory "tetris-scores"))

;; Functions

;; recompile modules directory
(defun personal-delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(defun personal-rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(defun personal-kill-emacs-hook ()
  (byte-recompile-directory personal-dir 0)
  (byte-recompile-file (concat user-emacs-directory "init.el") nil 0))

(add-hook 'kill-emacs-hook 'personal-kill-emacs-hook)

;; Keybindings

(global-set-key (kbd "C-x C-r") 'personal-rename-current-buffer-file)
(global-set-key (kbd "C-x C-k") 'personal-delete-current-buffer-file)

(provide 'personal-options)
