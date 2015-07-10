;;; -*- lexical-binding: t -*-

(p-require-package 'diminish)

(require 'p-mail)

(setq display-time-day-and-date t
      display-time-default-load-average nil
      display-time-mail-function #'p-unread-mail-p
      display-time-mail-string "✉"
      battery-mode-line-format " [%b%p%% (%t)]")

(display-time-mode 1)
(display-battery-mode 1)

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
          hi-lock
          ruby-tools
          ruby-end
          robe
          subword
          whitespace)
  (eval-after-load it
    `(diminish ',(-> it
                   (symbol-name)
                   (concat "-mode")
                   (intern)))))

(diminish 'visual-line-mode)

(eval-after-load 'yasnippet
  '(diminish 'yas-minor-mode))

(provide 'p-modeline)

;;; p-modeline.el ends here
