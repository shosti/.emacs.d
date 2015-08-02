(p-require-package 'aurel)

(with-eval-after-load 'aurel
  (add-to-list 'evil-emacs-state-modes 'aurel-list-mode)
  (p-add-hjkl-bindings aurel-list-mode-map 'emacs)
  (setq aurel-download-directory (expand-file-name "~/pkgs/")
        aurel-list-download-function #'aurel-download-unpack-pkgbuild))

(provide 'p-aurel)

;;; p-aurel.el ends here
