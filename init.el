;;; -*- lexical-binding: t -*-

(require 'cl-lib)

(defvar personal-dir (expand-file-name
                      (concat user-emacs-directory "personal")))

(add-to-list 'load-path personal-dir)

(setq custom-file (concat user-emacs-directory "custom.el")
      custom-theme-directory (concat user-emacs-directory "themes/"))

(message "Loading personal libraries...")

;; basic packages and functions come first...
(require 'personal-packages)
(require 'personal-functions)

;; and then everything else
(mapc (lambda (p) (require (intern p)))
      (mapcar (lambda (fname)
                (personal-trim-until-regexp fname "\.el$"))
              (personal-list-elisp-files personal-dir)))

(load-theme 'tomorrow-night t)

(server-start)
(eshell)
