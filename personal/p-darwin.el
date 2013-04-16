;;; -*- lexical-binding: t -*-

(p-require-package 'helm 'melpa)

(when (equal system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none)
  (define-key global-map [ns-drag-file] 'ns-find-file)
  (setq ns-pop-up-frames nil)

  (defvar locate-dirs
    '("~/.emacs.d" "~/src" "~/org" "~/Dropbox/src"))

  (setq helm-case-fold-search t)
  (setq helm-locate-case-fold-search t)

  (setq helm-locate-command
        (mapconcat 'identity
                   (cons "mdfind %s -name %s"
                         locate-dirs)
                   " -onlyin ")))

(provide 'p-darwin)
