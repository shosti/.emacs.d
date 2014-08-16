;;; -*- lexical-binding: t -*-

(defvar t-start (current-time))

(defvar p-dir (expand-file-name
               (concat user-emacs-directory "personal/")))
(defvar p-opt-dir (expand-file-name
                   (concat user-emacs-directory "opt/")))
(defvar p-private-dir (expand-file-name
                       (concat user-emacs-directory "private/")))

(add-to-list 'load-path p-dir)
(add-to-list 'load-path p-opt-dir)

(setq custom-file (concat p-private-dir "custom.el")
      default-directory (expand-file-name "~/")
      custom-theme-directory (concat user-emacs-directory "themes/"))

(load-file custom-file)

(message "Loading personal libraries...")

;; basic packages and functions come first...
(require 'p-packages)
(require 'p-macros)
(require 'p-functions)

;; and then everything else
(mapc (lambda (p)
        (require (intern p)))
      (mapcar (lambda (fname)
                (p-keep-until-regexp fname "\.el$"))
              (p-list-elisp-files p-dir)))

(load-theme 'tomorrow-night t)

(load-file (concat p-private-dir "private.el"))

(server-start)
(eshell)
(message "Emacs ready!")
(message "Total elapsed: %s" (float-time (time-subtract (current-time) t-start)))
