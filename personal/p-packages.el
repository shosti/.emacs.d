;;; -*- lexical-binding: t -*-

(require 'package)

(defvar p-melpa-packages nil
  "A list of packages that should be installed from melpa")

(setq package-archives
      (append package-archives
              '(("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
                ("melpa" . "http://melpa.milkbox.net/packages/")
                ("org" . "http://orgmode.org/elpa/")
                ("marmalade" . "http://marmalade-repo.org/packages/"))))

(package-initialize)

(unless (package-installed-p 'package-filter)
  (progn
    (switch-to-buffer
     (url-retrieve-synchronously
      "https://raw.github.com/milkypostman/package-filter/master/package-filter.el"))
    (package-install-from-buffer  (package-buffer-info) 'single)))

;; Don't get stable packages from melpa
(setq package-filter-function
      (lambda (package version archive)
        (or (not (string-equal archive "melpa"))
           (memq package p-melpa-packages))))

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar p-local-elisp-dev-dir (expand-file-name "~/src/elisp/"))

(defun p-require-package (package &optional repo)
  (if (eq repo 'local)
      (let ((local-src-dir
             (concat p-local-elisp-dev-dir
                     (symbol-name package))))
        (if (file-exists-p local-src-dir)
            (progn
              (add-to-list 'load-path local-src-dir)
              (require package))
          (p-require-package package 'melpa)))
    (let ((is-melpa (equal repo 'melpa)))
      (when is-melpa
        (add-to-list 'p-melpa-packages package))
      (unless (package-installed-p package)
        (when is-melpa
          (package-refresh-contents))
        (package-install package)))))

(require 'p-starter-kit)

(provide 'p-packages)
