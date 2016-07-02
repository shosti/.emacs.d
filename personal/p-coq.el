(require 'proof-site nil t)

(defconst p-coq-symbols
  '(("->" . ?→)
    ("==>" . ?⇒)
    ("forall" . ?∀)
    ("|-" . ?⊢)
    ("\\/" . ?∨)
    ("\\in" . ?∈)
    ("exists" . ?∃)))

(defun p-set-up-coq-mode ()
  (seq-each (lambda (sym)
              (push sym prettify-symbols-alist))
            p-coq-symbols)
  (prettify-symbols-mode 1))

(with-eval-after-load 'coq
  (add-hook 'coq-mode-hook #'p-set-up-coq-mode))

(provide 'p-coq)

;;; p-coq.el ends here
