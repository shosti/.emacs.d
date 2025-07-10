(p-require-package 'eat 'nongnu)

(require 'p-evil)

(add-to-list 'evil-emacs-state-modes 'eat-mode)

(with-eval-after-load 'eat
  (mapcar #'(lambda (k)
              (define-key eat-semi-char-mode-map (kbd k) nil))
          '("M-0" "M-1" "M-2" "M-3" "M-o")))

(provide 'p-eat)

;;; p-eat.el ends here
