(add-to-list 'load-path (expand-file-name "~/src/elisp/direnv-mode"))
(require 'direnv nil 'nerror)

(with-eval-after-load 'direnv
  ;; (global-direnv-mode)
  )

(provide 'p-direnv)

;;; p-direnv.el ends here
