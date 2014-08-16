;;; -*- lexical-binding: t -*-

(setq org-startup-indented t)

(defun p-eval-text-block ()
  "Quick hack to evaluate and insert values of Elisp code blocks.

This function assumes that for the code block under the block is
split into two sections, first the definitions (whose values
shouldn't be printed) and then the example values."
  (interactive)
  (save-excursion
    (let ((start (region-beginning))
          (end (region-end)))
      (goto-char start)
      (let ((definitions-end
              (save-excursion (re-search-forward "^$"))))
        (while (< (point) end)
          (forward-sexp)
          (let ((val (eval (preceding-sexp))))
            (when (> (point) definitions-end)
              (insert (format " ; => %S" val))))))
      (goto-char start)
      (align-regexp start end "\\(\\s-*\\); =>"))))

(defun p-set-up-org-mode ()
  (auto-fill-mode 1)
  (flyspell-mode 1))

(add-hook 'org-mode-hook 'p-set-up-org-mode)

(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))

(provide 'p-org)
