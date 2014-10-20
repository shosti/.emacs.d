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

(defun p-require-package (package &optional repo-symbol)
  (let ((repo (if (null repo-symbol) "melpa-stable"
                (symbol-name repo-symbol))))
    (if (eq repo-symbol 'local)
        (let ((local-src-dir
               (concat p-local-elisp-dev-dir
                       (symbol-name package))))
          (if (file-exists-p local-src-dir)
              (progn
                (add-to-list 'load-path local-src-dir)
                (require package))
            (p-require-package package 'melpa)))
      (add-to-list 'package-pinned-packages
                   (cons package repo))
      ;; Not entirely sure why this is necessary
      (unless (package-installed-p package)
	(let ((package-archives
	       (cl-remove-if-not (lambda (archive)
				   (equal (car archive) repo))
				 package-archives)))
	  (package-refresh-contents)
	  (package-install package))))))

;; Miscellaneous packages where I don't know where to put them and I
;; don't want the MELPA version

(p-require-package 'concurrent)
(p-require-package 'ctable)
(p-require-package 'db 'marmalade)
(p-require-package 'epc)
(p-require-package 'esxml 'marmalade)
(p-require-package 'findr 'marmalade)
(p-require-package 'inflections)
(p-require-package 'jump)
(p-require-package 'kv 'marmalade)
(p-require-package 'logito)
(p-require-package 'noflet 'marmalade)
(p-require-package 'pkg-info)
(p-require-package 'pcache)
(p-require-package 'pcsv 'marmalade)
(p-require-package 'request-deferred)

(provide 'p-packages)

;;; p-packages.el ends here
