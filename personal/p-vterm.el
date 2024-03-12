(p-require-package 'vterm 'melpa)

(require 'p-org)
(require 'p-leader)

(add-to-list 'evil-emacs-state-modes 'vterm-mode)

(setq vterm-max-scrollback 10000)

(with-eval-after-load 'vterm
  (mapcar #'(lambda (k)
              (define-key vterm-mode-map (kbd k) nil))
          '("M-0" "M-1" "M-2" "M-3")))

(p-set-leader-key "Z" #'vterm)

(provide 'p-vterm)

;;; p-vterm.el ends here
