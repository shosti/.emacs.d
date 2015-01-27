;;; -*- lexical-binding: t -*-

(p-require-package 'diminish)
(p-require-package 'powerline 'melpa)
(p-require-package 'powerline-evil 'melpa)

(require 'p-mail)

(powerline-evil-center-color-theme)
(setq display-time-day-and-date t
      display-time-default-load-average nil
      display-time-mail-function #'p-unread-mail-p
      display-time-mail-string "✉")

(display-time-mode 1)

(with-eval-after-load 'mu4e
  (advice-add 'mu4e-quit :after #'display-time-update))

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
