;;; -*- lexical-binding: t -*-

(require 'cl-lib)

(defvar personal-dir (expand-file-name
                      (concat user-emacs-directory "personal")))

(add-to-list 'load-path personal-dir)

(setq custom-file (concat user-emacs-directory "custom.el")
      custom-theme-directory (concat user-emacs-directory "themes/"))

;; basic functions and packages come first...
(require 'personal-functions)
(require 'personal-packages)

;; and then everything else
(mapc (lambda (p) (require (intern p)))
      (mapcar (lambda (fname)
                (personal-trim-until-regexp fname "\.el$"))
              (personal-list-elisp-files personal-dir)))

(load-theme 'tomorrow-night t)

(server-start)
(eshell)
