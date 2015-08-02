(p-require-package 'gist)

(require 'p-evil)

(with-eval-after-load 'gist
  (p-add-hjkl-bindings gist-list-menu-mode-map 'emacs
    "K" #'gist-kill-current))

(provide 'p-gist)

;;; p-gist.el ends here
