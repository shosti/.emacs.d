;;; -*- lexical-binding: t -*-

(require 'cl-lib)

(defvar p-dir (expand-file-name
               (concat user-emacs-directory "personal")))
(defvar p-opt-dir (expand-file-name
                   (concat user-emacs-directory "opt")))

(add-to-list 'load-path p-dir)
(add-to-list 'load-path p-opt-dir)

(setq custom-file (concat user-emacs-directory "custom.el")
      custom-theme-directory (concat user-emacs-directory "themes/"))

(load-file custom-file)

(message "Loading personal libraries...")

;; basic packages and functions come first...
(require 'p-packages)
(require 'p-functions)

;; and then everything else
(mapc (lambda (p)
        (message "Loading %s..." p)
        (require (intern p)))
      (mapcar (lambda (fname)
                (p-keep-until-regexp fname "\.el$"))
              (p-list-elisp-files p-dir)))

(load-theme 'tomorrow-night t)

(server-start)
(eshell)
(message "Emacs ready!")
