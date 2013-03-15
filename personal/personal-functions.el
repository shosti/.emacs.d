;;; -*- lexical-binding: t -*-

(defun personal-list-elisp-files (dir)
  (cl-remove-if-not (lambda (fname)
                   (string-match "\.el$" fname))
                 (directory-files dir)))

(defun personal-trim-until-regexp (s re)
  (substring s 0 (string-match re s)))

(defun personal-any (pred xs)
  (cl-reduce (lambda (result x)
               (or result (funcall pred x)))
             xs
             :initial-value nil))

(defun personal-all (pred xs)
  (cl-reduce (lambda (result x)
               (and result (funcall pred x)))
             xs
             :initial-value t))

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

(defun personal-paredit-backward-kill-word ()
  "Paredit replacement for backward-kill-word."
  (interactive)
  (if (use-region-p)
      (paredit-kill-region (region-beginning) (region-end))
    (paredit-backward-kill-word)))

(defun personal-move-line-down (arg)
  "Move current line down while staying on current line"
  (interactive "p")
  (beginning-of-line)
  (newline arg)
  (indent-for-tab-command)
  (previous-line arg)
  (indent-for-tab-command))

(defun personal-path-from-file (fpath)
  "Reads a :-delineated path file and adds
it to exec-path and the PATH variable"
  (with-temp-buffer
    (insert-file-contents fpath)
    (setq exec-path
          (append (mapcar 'chomp (split-string (buffer-string) ":" t))
                  exec-path))
    (setenv "PATH" (mapconcat 'identity exec-path ":"))))

(provide 'personal-functions)
