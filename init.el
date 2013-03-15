;;; -*- lexical-binding: t -*-

(require 'cl-lib)

(defvar personal-dir (expand-file-name
                      (concat user-emacs-directory "personal")))

(add-to-list 'load-path personal-dir)

;; basic functions and packages come first...
(require 'personal-functions)
(require 'personal-packages)

;; and then everything else
(mapc (lambda (p) (require (intern p)))
      (mapcar (lambda (fname)
                (personal-trim-until-regexp fname "\.el$"))
              (personal-list-elisp-files personal-dir)))
