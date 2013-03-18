;;; -*- lexical-binding: t -*-
;;; Settings and keybindings for general editing

;; Settings

(global-subword-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(delete-selection-mode 1)

;; Functions

(defun personal-backward-kill-word (arg)
  "If the region is active, kills region.  Otherwise, backwards kills word."
  (interactive "p")
  (if transient-mark-mode
      (if (use-region-p)
          (kill-region (region-beginning) (region-end))
        (if subword-mode
            (subword-backward-kill arg)
          (backward-kill-word arg)))
    (kill-region (region-beginning) (region-end))))

(defun personal-move-line-down (arg)
  "Move current line down while staying on current line"
  (interactive "p")
  (beginning-of-line)
  (newline arg)
  (indent-for-tab-command)
  (previous-line arg)
  (indent-for-tab-command))

(defun personal-eol-and-ret (arg)
  "Move to the next line without altering current line"
  (interactive "p")
  (end-of-line)
  (newline arg)
  (indent-for-tab-command))

(defun personal-join-next-line () ; thanks to whattheemacsd
  (interactive)
  (join-line -1))

(defun personal-package-name ()
  (personal-trim-until-regexp
   (car (last (split-string (buffer-file-name) "/")))
   "\.el$"))

;; more whattheemacsd goodness
(defun personal-fast-next-line ()
  (interactive)
  (ignore-errors (next-line 5)))

(defun personal-fast-previous-line ()
  (interactive)
  (ignore-errors (previous-line 5)))

(defun personal-fast-forward-char ()
  (interactive)
  (ignore-errors (forward-char 5)))

(defun personal-fast-backward-char ()
  (interactive)
  (ignore-errors (backward-char 5)))

;; Keybindings

(global-set-key (kbd "<S-return>") 'personal-eol-and-ret)
(global-set-key (kbd "<C-return>") 'personal-move-line-down)
(global-set-key (kbd "C-w") 'personal-backward-kill-word)
(global-set-key (kbd "M-j") 'personal-join-next-line)
(global-set-key (kbd "C-M-j") 'join-line)
(global-set-key (kbd "C-M-h") 'mark-defun) ; undo starter-kit binding
(global-set-key (kbd "C-S-n") 'personal-fast-next-line)
(global-set-key (kbd "C-S-p") 'personal-fast-previous-line)
(global-set-key (kbd "C-S-f") 'personal-fast-forward-char)
(global-set-key (kbd "C-S-b") 'personal-fast-backward-char)

(provide 'personal-editing)
