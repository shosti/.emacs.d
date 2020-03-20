;;; -*- lexical-binding: t -*-

(p-require-package 'diminish)

(require 'p-gnus)

(setq display-time-day-and-date nil
      display-time-default-load-average nil
      display-time-mail-string "✉"
      battery-mode-line-format " [%b%p%% (%t)]")

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
