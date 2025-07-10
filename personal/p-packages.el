;;; -*- lexical-binding: t -*-

(require 'package)

(defvar p-melpa-packages nil
  "A list of packages that should be installed from melpa")

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

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

(p-require-package 'compat 'gnu)

;; They removed global-linum-mode from emacs 29 :( . Set this to keep the
;; compiler happy. See https://github.com/emacsorphanage/git-gutter/issues/226
(setq global-linum-mode nil)

(provide 'p-packages)

;;; p-packages.el ends here
