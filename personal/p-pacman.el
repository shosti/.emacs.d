(autoload 'pacman (concat user-emacs-directory "vendor/pacman.el") nil t)

(with-eval-after-load 'pacman
  (add-to-list 'evil-emacs-state-modes 'pacman-mode)
  (p-add-hjkl-bindings pacman-mode-map 'emacs
    "L" #'pacman-mode-list-installed-packages))

(provide 'p-pacman)
;; p-pacman.el ends here
