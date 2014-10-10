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

(provide 'p-packages)
