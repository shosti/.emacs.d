;;; -*- lexical-binding: t -*-
;;; Miscellaneous options and settings

(p-require-package 'backup-each-save 'melpa)
(p-require-package 'rainbow-mode 'gnu)
(p-require-package 'request)

(require 'p-path)
(require 'uniquify)
(require 'p-leader)

;;;;;;;;;;;;;;
;; Settings ;;
;;;;;;;;;;;;;;

(defalias 'yes-or-no-p 'y-or-n-p)

;; Hack to disable popup dialogs

(setq use-dialog-box nil)

(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

(setq disabled-command-function nil
      dired-use-ls-dired nil
      uniquify-buffer-name-style 'forward
      visible-bell t
      inhibit-startup-message t
      save-place-file "~/.emacs.d/places"
      diff-switches "-u"
      ediff-window-setup-function 'ediff-setup-windows-plain
      load-prefer-newer t
      shr-external-browser browse-url-browser-function
      find-function-C-source-directory (expand-file-name "~/src/emacs/src")
      ;; shr seems to crap out with the default limit
      max-specpdl-size 3900
      netrc-file "~/.netrc.gpg"
      auth-sources '("~/.netrc.gpg")
      gnutls-verify-error t)

(when (eq system-type 'gnu/linux)
  (setq browse-url-browser-function 'browse-url-chromium))

(setq-default imenu-auto-rescan t)

(add-to-list 'safe-local-variable-values '(lexical-binding . t))

(blink-cursor-mode 0)

(require 'warnings)
(add-to-list 'warning-suppress-types
             '(undo discard-info))

;;;;;;;;;;;;
;; Backup ;;
;;;;;;;;;;;;

(setq make-backup-files nil
      auto-save-default nil
      backup-each-save-filter-function 'p-backup-each-save-filter)
(add-hook 'after-save-hook 'backup-each-save)

;;;;;;;;;;
;; File ;;
;;;;;;;;;;

(setq large-file-warning-threshold 100000000
      recentf-max-saved-items 200
      delete-by-moving-to-trash t
      trash-directory (expand-file-name "~/.Trash"))

(setq-default major-mode 'text-mode)
(add-to-list 'Info-directory-list
             (expand-file-name (concat user-emacs-directory "info")))

(setq tetris-score-file (concat user-emacs-directory "tetris-scores"))

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;

(defun p-backup-each-save-filter (filename)
  (let ((ignored-filenames
         '("^/tmp" "semantic.cache$" "\\.emacs-places$"
           "\\.recentf$" ".newsrc\\(\\.eld\\)?"))
        (matched-ignored-filename nil))
    (mapc
     (lambda (x)
       (when (string-match x filename)
         (setq matched-ignored-filename t)))
     ignored-filenames)
    (not matched-ignored-filename)))

(defun p-delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename t)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(defun p-rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name))
        (read-file-name-function #'read-file-name-default))
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

(defvar-local p-test-runner #'ert-run-tests-interactively)

(defun p-run-tests ()
  (interactive)
  (call-interactively p-test-runner))

;; Nice hack from Stack Overflow
(defun p-maybe-make-directory ()
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p buffer-file-name)
    (let ((dir (file-name-directory buffer-file-name)))
      (unless (file-exists-p dir)
        (make-directory dir t)))))

(add-hook 'find-file-hook 'p-maybe-make-directory)

;; Ripped from Emacs Prelude
(defun p-open-with (arg)
  "Open visited file in default external program.

With a prefix ARG always prompt for command to use."
  (interactive "P")
  (when buffer-file-name
    (start-process "prelude-open-with-process"
                   "*prelude-open-with-output*"
                   (cond
                    ((and (not arg) (eq system-type 'darwin)) "open")
                    ((and (not arg) (member system-type '(gnu gnu/linux gnu/kfreebsd))) "xdg-open")
                    (t (read-shell-command "Open current file with: ")))
                   (shell-quote-argument buffer-file-name))))

(defun p-tmp-buffer (arg)
  (interactive "P")
  (let ((buffer-name (if arg
                         (concat "*tmp*<" (number-to-string arg) ">")
                       "*tmp*")))
    (switch-to-buffer-other-window buffer-name)))

(p-set-leader-key
  "T" 'p-tmp-buffer)

;; recompile modules directory
(defun p-kill-emacs-hook ()
  (byte-recompile-directory p-dir 0)
  (unless (file-exists-p (concat user-init-file "c"))
    (byte-compile-file user-init-file)))

(add-hook 'kill-emacs-hook 'p-kill-emacs-hook)

;; Hack to prevent excess garbage collection
(defun p-prevent-gc ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun p-enable-gc ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'p-prevent-gc)
(add-hook 'minibuffer-exit-hook #'p-enable-gc)


(provide 'p-options)

;;; p-options.el ends here
