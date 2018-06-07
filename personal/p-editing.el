;;; -*- lexical-binding: t -*-
;;; Settings and keybindings for general editing

(p-require-package 'vlf)
(p-require-package 'ws-butler)

(require 'p-leader)
(require 'p-git)

;;;;;;;;;;;;;;
;; Settings ;;
;;;;;;;;;;;;;;

(global-subword-mode 1)
(global-auto-revert-mode 1)
(delete-selection-mode 1)
(setq-default require-final-newline t
              indent-tabs-mode nil
              tab-width 2
              fill-column 80)
(auto-fill-mode 0)

(defun p-set-up-text-mode ()
  (auto-fill-mode 1)
  (flyspell-mode 1))

(add-hook 'text-mode-hook 'p-set-up-text-mode)

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;


(defun p-untabify-buffer ()
  (interactive)
  (unless indent-tabs-mode
    (untabify (point-min) (point-max))))

(defun p-indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun p-cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (p-indent-buffer)
  (p-untabify-buffer)
  (delete-trailing-whitespace))

(defun p-lorem ()
  "Insert a lorem ipsum."
  (interactive)
  (insert "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
          "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim"
          "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
          "aliquip ex ea commodo consequat. Duis aute irure dolor in "
          "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
          "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
          "culpa qui officia deserunt mollit anim id est laborum."))

(defun p-insert-date ()
  "Insert a time-stamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%F" (current-time))))

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

(defun p-delete-current-line ()
  (interactive)
  (beginning-of-line)
  (kill-line 1)
  (beginning-of-line-text))

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

;;;;;;;;;;;;
;; Saving ;;
;;;;;;;;;;;;

;; Stolen from evil-mode
(defun p-save-all ()
  (save-some-buffers t
                     (lambda ()
                       (and (not buffer-read-only)
                            (buffer-file-name)))))

(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))

(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

(defadvice magit-status (before save-all activate)
  (p-save-all))

(add-hook 'focus-out-hook 'p-save-all)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(define-key ctl-x-map "\C-i"
  #'p-ispell-word-then-abbrev)

;; Stolen from
;; http://endlessparentheses.com/ispell-and-abbrev-the-perfect-auto-correct.html
(defun p-ispell-word-then-abbrev (p)
  "Call `ispell-word', then create an abbrev for it.
With prefix P, create local abbrev. Otherwise it will
be global.
If there's nothing wrong with the word at point, keep
looking for a typo until the beginning of buffer. You can
skip typos you don't want to fix with `SPC', and you can
abort completely with `C-g'."
  (interactive "P")
  (let (bef aft)
    (save-excursion
      (while (if (setq bef (thing-at-point 'word))
                 ;; Word was corrected or used quit.
                 (if (ispell-word nil 'quiet)
                     nil                  ; End the loop.
                   ;; Also end if we reach `bob'.
                   (not (bobp)))
               ;; If there's no word at point, keep looking
               ;; until `bob'.
               (not (bobp)))
        (backward-word))
      (setq aft (thing-at-point 'word)))
    (if (and aft bef (not (equal aft bef)))
        (let ((aft (downcase aft))
              (bef (downcase bef)))
          (define-abbrev
            (if p local-abbrev-table global-abbrev-table)
            bef aft)
          (message "\"%s\" now expands to \"%s\" %sally"
                   bef aft (if p "loc" "glob")))
      (user-error "No typo at or before point"))))

(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)

(defun p-kill-ring-save-current-buffer ()
  (interactive)
  (let ((fname (cond
                (buffer-file-name)
                ((eq major-mode 'dired-mode) default-directory))))
    (when fname
      (kill-new fname)
      (message "%s" fname))))

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

(global-set-key (kbd "<S-return>") 'p-eol-and-ret)
(global-set-key (kbd "<C-return>") 'p-move-line-down)
(global-set-key (kbd "C-w") 'p-backward-kill-word)
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "C-S-k") 'p-delete-current-line)
(global-set-key (kbd "M--") (lambda () (interactive) (insert "—")))
(global-set-key " " 'just-one-space)
(p-set-leader-key "n" 'p-cleanup-buffer)
(p-set-leader-key "Y" 'p-kill-ring-save-current-buffer)

(provide 'p-editing)

;;; p-editing.el ends here
