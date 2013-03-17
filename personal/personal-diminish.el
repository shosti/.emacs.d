(require 'diminish)

(eval-after-load 'elisp-slime-nav
  '(diminish 'elisp-slime-nav-mode))
(eval-after-load 'highlight-parentheses
  '(diminish 'highlight-parentheses-mode))
(eval-after-load 'yasnippet
  '(diminish 'yas-minor-mode))
(eval-after-load 'eldoc
  '(diminish 'eldoc-mode))
(eval-after-load 'paredit
  '(diminish 'paredit-mode))
(eval-after-load 'undo-tree
  '(diminish 'undo-tree-mode))
(diminish 'visual-line-mode)
(eval-after-load 'auto-complete
  '(diminish 'auto-complete-mode))

(provide 'personal-diminish)
