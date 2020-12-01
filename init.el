;;; -*- lexical-binding: t -*-

(defvar t-start (current-time))
(defvar p-dir (expand-file-name
               (concat user-emacs-directory "personal/")))
(defvar p-opt-dir (expand-file-name
                   (concat user-emacs-directory "opt/")))
(defvar p-private-dir (expand-file-name
                       (concat user-emacs-directory "private/")))

;; Performance hacks
(let ((gc-cons-threshold most-positive-fixnum)
      (file-name-handler-alist nil))
  (add-to-list 'load-path p-dir)
  (add-to-list 'load-path p-opt-dir)

  (setq custom-file (concat p-private-dir "custom.el")
        default-directory (expand-file-name "~/")
        custom-theme-directory (concat user-emacs-directory "themes/"))

  (load-file custom-file)

  (message "Loading personal libraries...")

  ;; basic packages and functions come first...
  (require 'cl-lib)
  (require 'p-packages)
  (require 'p-functions)

  ;; and then everything else
  (mapc (lambda (p)
          (require (intern p)))
        (mapcar (lambda (fname)
                  (p-keep-until-regexp fname "\.el$"))
                (p-list-elisp-files p-dir)))

  (load-file (concat p-private-dir "private.el"))

  (require 'server)
  (if (server-running-p)
      ;; Let us know we're in an auxiliary emacs
      (set-face-attribute 'mode-line nil
                          :background "yellow")
    (server-start))

  (shell)
  (message "Emacs ready!")
  (message "Total elapsed: %s" (float-time (time-subtract (current-time) t-start)))

  (when noninteractive
    (message "Compiling and exiting...")
    (byte-recompile-directory p-dir 0)
    (byte-compile-file (concat user-emacs-directory "init.el"))
    (kill-emacs)))
