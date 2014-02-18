(p-require-package 'dash-at-point 'melpa)

(require 'p-evil)

(define-key evil-normal-state-map "gc" 'dash-at-point)
(define-key evil-normal-state-map "gC" 'dash-at-point-with-docset)

(add-to-list 'dash-at-point-mode-alist
             '(haml-mode . "haml,rails,ruby"))

(provide 'p-docs)

;;; p-docs.el ends here
