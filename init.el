;;; -*- lexical-binding: t -*-

(require 'cl-lib)

(defvar p-dir (expand-file-name
                      (concat user-emacs-directory "personal")))

(add-to-list 'load-path p-dir)

(setq custom-file (concat user-emacs-directory "custom.el")
      custom-theme-directory (concat user-emacs-directory "themes/"))

(message "Loading personal libraries...")

;; basic packages and functions come first...
(require 'p-packages)
(require 'p-functions)

;; and then everything else
(mapc (lambda (p) (require (intern p)))
      (mapcar (lambda (fname)
                (p-trim-until-regexp fname "\.el$"))
              (p-list-elisp-files p-dir)))

(load-theme 'tomorrow-night t)

(server-start)
(eshell)
