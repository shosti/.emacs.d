;;; -*- lexical-binding: t -*-

(p-require-package 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
(setq js-indent-level 2
      js-switch-indent-offset 2
      js2-mode-show-strict-warnings nil
      mocha-options "--recursive --compilers js:babel-register"
      typescript-indent-level 2)

(defconst p-js-symbols
  '(("=>" . ?⇒)
    ("null" . ?∅)))

(defun p-js-comint-filter (output)
  (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                            (replace-regexp-in-string ".*1G.*3G" "> "
                                                      output)))

(defun set-up-inferior-js-mode ()
  (setq comint-process-echoes t)
  (add-to-list 'comint-preoutput-filter-functions
               'p-js-comint-filter))

(defun p-js-switch-between-imp-and-test ()
  (interactive)
  (let* ((fname buffer-file-name)
         (in-test (s-matches? "__tests__/" fname))
         (new-fname
          (if in-test
              (s-replace "__tests__/" "" fname)
            (concat (file-name-directory fname)
                    "__tests__/"
                    (file-name-nondirectory fname)))))
    (if (file-exists-p new-fname)
        (find-file new-fname)
      (user-error "%s does not exist" new-fname))))

(defun p-set-up-js2-mode ()
  (seq-each (lambda (sym)
              (push sym prettify-symbols-alist))
            p-js-symbols)
  (setq-local sgml-basic-offset js-indent-level)
  (flycheck-mode 1)
  (prettify-symbols-mode 1))

(with-eval-after-load 'js2-mode
  (add-hook 'js2-mode-hook #'p-set-up-js2-mode))

(setq prettier-js-command "prettier"
      prettier-js-args '())

(provide 'p-js)

;;; p-js.el ends here
