(autoload 'pacman (concat user-emacs-directory "vendor/pacman.el") nil t)

(with-eval-after-load 'pacman
  (add-to-list 'evil-motion-state-modes 'pacman-mode))

(provide 'p-pacman)
;; p-pacman.el ends here
