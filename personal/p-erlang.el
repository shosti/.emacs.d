(let ((erl-dir "/usr/lib/erlang/lib/tools-2.8.2/emacs"))
  (when (file-directory-p erl-dir)
    (add-to-list 'load-path erl-dir)
    (require 'erlang-start)
    (add-to-list 'auto-mode-alist
                 '("\\.erl\\'" . erlang-mode))))

(provide 'p-erlang)

;;; p-erlang.el ends here
