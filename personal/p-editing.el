;;; -*- lexical-binding: t -*-
;;; Settings and keybindings for general editing

;;;;;;;;;;;;;;
;; Settings ;;
;;;;;;;;;;;;;;

(global-subword-mode 1)
(global-auto-revert-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(delete-selection-mode 1)

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;

(defun p-backward-kill-word (arg)
  "If the region is active, kills region.  Otherwise, backwards kills word."
  (interactive "p")
  (if transient-mark-mode
      (if (use-region-p)
          (kill-region (region-beginning) (region-end))
        (if subword-mode
            (subword-backward-kill arg)
          (backward-kill-word arg)))
    (kill-region (region-beginning) (region-end))))

(defun p-move-line-down (arg)
  "Move current line down while staying on current line"
  (interactive "p")
  (beginning-of-line)
  (newline arg)
  (indent-for-tab-command)
  (forward-line (- arg))
  (indent-for-tab-command))

(defun p-eol-and-ret (arg)
  "Move to the next line without altering current line"
  (interactive "p")
  (end-of-line)
  (newline arg)
  (indent-for-tab-command))

(defun p-join-next-line () ; thanks to whattheemacsd
  (interactive)
  (join-line -1))

(defun p-package-name ()
  (p-keep-until-regexp
   (car (last (split-string (buffer-file-name) "/")))
   "\.el$"))

;; more whattheemacsd goodness
(defun p-fast-next-line ()
  (interactive)
  (ignore-errors (forward-line 5)))

(defun p-fast-previous-line ()
  (interactive)
  (ignore-errors (forward-line -5)))

(defun p-fast-forward-char ()
  (interactive)
  (ignore-errors (forward-char 5)))

(defun p-fast-backward-char ()
  (interactive)
  (ignore-errors (backward-char 5)))

(defun p-duplicate-line (&optional n)
  (interactive "p")
  (cl-dotimes (_ n)
    (save-excursion
      (copy-region-as-kill (line-beginning-position) (line-end-position))
      (end-of-line)
      (newline)
      (beginning-of-line)
      (yank))
    (forward-line)))

(defun p-goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

(global-set-key [remap goto-line] 'p-goto-line-with-feedback)
(global-set-key (kbd "<S-return>") 'p-eol-and-ret)
(global-set-key (kbd "<C-return>") 'p-move-line-down)
(global-set-key (kbd "C-w") 'p-backward-kill-word)
(global-set-key (kbd "M-j") 'p-join-next-line)
(global-set-key (kbd "C-M-j") 'join-line)
(global-set-key (kbd "C-M-h") 'mark-defun) ; undo starter-kit binding
(global-set-key (kbd "C-S-n") 'p-fast-next-line)
(global-set-key (kbd "C-S-p") 'p-fast-previous-line)
(global-set-key (kbd "C-S-f") 'p-fast-forward-char)
(global-set-key (kbd "C-S-b") 'p-fast-backward-char)
(global-set-key (kbd "C-c d") 'p-duplicate-line)
(global-set-key (kbd "C-x \\") 'align-regexp)

(provide 'p-editing)

;;; p-editing.el ends here
