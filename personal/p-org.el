;;; -*- lexical-binding: t -*-

(require 'p-evil)
(require 'p-leader)

(defun p-pretty-eval-org-src-block ()
  "Evaluate and insert values of Elisp code blocks.

This function assumes that the code block is split into two
sections: the definitions (whose values shouldn't be printed);
and the example values (which will be printed). The cursor should
point to the divide between the definitions and examples."
  (interactive)
  (save-excursion
    (let ((examples-start (point))
          (start (progn
                   (re-search-backward "BEGIN_SRC")
                   (forward-line)
                   (beginning-of-line)
                   (point)))
          ;; end position could change, so we have to compare by line
          ;; number.
          (end-line (progn
                      (re-search-forward "END_SRC")
                      (line-number-at-pos))))
      (replace-regexp " *; =>.*$" "" nil start (p-line-start end-line))
      (goto-char start)
      (while (progn
               (forward-sexp)
               (< (line-number-at-pos) end-line))
        (condition-case err
            (let ((expr (preceding-sexp)))
              ;; defvars should be redefined, so they have to be
              ;; unbound
              (when (and (consp expr) (eq (car expr) 'defvar))
                (makunbound (cadr expr)))
              (let ((val (eval (preceding-sexp))))
                (when (> (point) examples-start)
                  (insert (format " ; => %s" val)))))
          (error (insert (format " ; => ERROR %s" err)))))
      (goto-char start)
      (align-regexp start (p-line-start end-line) "\\(\\s-*\\); =>"))))

(defalias 'peb 'p-pretty-eval-org-src-block)

(defun p-org-meta-return (&optional arg)
  "Hack to make M-RET work right with Evil (and in general)."
  (interactive)
  (end-of-line)
  (org-meta-return arg))

(p-configure-feature org
  (setq org-startup-indented t
        org-src-fontify-natively t
        org-agenda-files (concat org-directory "/agenda.org"))

  (add-to-list 'org-structure-template-alist
               '("se"
                 "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"
                 "<src lang=\"emacs-lisp\">\n\n</src>"))

  (org-defkey org-mode-map [(meta return)] 'p-org-meta-return))

(p-configure-feature org-agenda
  (p-add-hjkl-bindings org-agenda-mode-map 'emacs
    "J" 'org-agenda-goto-date))

(defun p-set-up-org-mode ()
  (auto-fill-mode 1)
  (flyspell-mode 1))

(add-hook 'org-mode-hook 'p-set-up-org-mode)

(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))

(defun p-find-org-file ()
  (interactive)
  (let ((ido-use-filename-at-point nil))
    (ido-find-file-in-dir org-directory)))

(p-set-leader-key
  "o" (make-sparse-keymap)
  "oc" 'org-capture
  "oa" 'org-agenda
  "of" 'p-find-org-file)

(provide 'p-org)

;;; p-org.el ends here
