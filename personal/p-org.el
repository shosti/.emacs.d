;;; -*- lexical-binding: t -*-
(p-require-package 'org-plus-contrib 'org)
(p-require-package 'ox-reveal 'melpa)

(require 'p-evil)
(require 'p-leader)

(setq org-directory (expand-file-name "~/org")
      org-default-notes-file (concat org-directory "/todo.org")
      org-agenda-files (concat org-directory "/agenda.org")
      org-list-allow-alphabetical t
      org-startup-indented t
      org-src-fontify-natively t
      org-irc-link-to-logs t
      org-todo-keywords '((sequence "☛ TODO(t)" "|" "DONE(d)")
                          (sequence "⚑ WAITING(w)" "|")
                          (sequence "|" "✘ CANCELED(c)")))

(with-eval-after-load 'org
  (require 'ox-reveal)
  (require 'ox-md)
  (add-to-list 'org-structure-template-alist
               '("se"
                 "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"
                 "<SRC lang=\"emacs-lisp\">\n\n</src>"))

  (org-defkey org-mode-map [(meta return)] 'p-org-meta-return))

(with-eval-after-load 'org-agenda
  (p-add-hjkl-bindings org-agenda-mode-map 'emacs
    "J" 'org-agenda-goto-date))

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

(defun p-set-up-org-mode ()
  (auto-fill-mode 1)
  (flyspell-mode 1)
  (p-company-emoji-init))

(add-hook 'org-mode-hook 'p-set-up-org-mode)

(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))

(defun p-find-org-file ()
  (interactive)
  (let ((ido-use-filename-at-point nil))
    (ido-find-file-in-dir org-directory)))

;(defadvice)

;; Keybindings
;;
;; Some of them are stolen from evil-org, which unfortunately doesn't
;; seem to work.
(with-eval-after-load 'org
  (evil-define-key 'normal org-mode-map
    "^" 'org-beginning-of-line
    "$" 'org-end-of-line
    (kbd "M-l") 'org-metaright
    (kbd "M-h") 'org-metaleft
    (kbd "M-L") 'org-shiftmetaright
    (kbd "M-H") 'org-shiftmetaleft
    (kbd "C-S-L") 'org-shiftcontrolright
    (kbd "C-S-H") 'org-shiftcontrolleft
    (kbd "M-k") 'org-metaup
    (kbd "M-j") 'org-metadown
    (kbd "M-K") 'org-shiftmetaup
    (kbd "M-J") 'org-shiftmetadown
    (kbd "M-v") 'org-mark-element
    (kbd "M-p") 'org-yank
    (kbd "C-S-K") 'org-shiftcontrolup
    (kbd "C-S-J") 'org-shiftcontroldown)

  (add-hook 'org-mode-hook #'org-bullets-mode))

(p-set-leader-key
  "o" (make-sparse-keymap)
  "oc" 'org-capture
  "oa" 'org-agenda
  "of" 'p-find-org-file
  "ol" 'org-store-link)

(provide 'p-org)

;;; p-org.el ends here
