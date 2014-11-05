;;; -*- lexical-binding: t -*-

(p-require-package 'diminish)
(p-require-package 'powerline 'melpa)
(p-require-package 'powerline-evil 'melpa)

(powerline-evil-center-color-theme)
(setq display-time-day-and-date t)
(display-time-mode 1)

(require 'diminish)

(--each '(elisp-slime-nav
          highlight-parentheses
          eldoc
          paredit
          undo-tree
          company
          git-gutter
          redshank
          projectile
          ruby-tools
          ruby-end
          robe)
  (eval-after-load it
    `(diminish ',(-> it
                   (symbol-name)
                   (concat "-mode")
                   (intern)))))

(eval-after-load 'yasnippet
  '(diminish 'yas-minor-mode))

(provide 'p-modeline)

;;; p-modeline.el ends here
