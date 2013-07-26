;;; -*- lexical-binding: t -*-

(p-require-package 's 'melpa)
(p-require-package 'dash 'melpa)

(require 's)
(require 'dash)

(defun p-list-elisp-files (dir)
  (cl-remove-if-not (lambda (fname)
                   (string-match "\.el$" fname))
                 (directory-files dir)))

(defun p-keep-until-regexp (s re)
  (substring s 0 (string-match re s)))

(defun p-any (pred xs)
  (cl-reduce (lambda (result x)
               (or result (funcall pred x)))
             xs
             :initial-value nil))

(defun p-all (pred xs)
  (cl-reduce (lambda (result x)
               (and result (funcall pred x)))
             xs
             :initial-value t))

(defun p-chomp (str)
  "..."
  (let ((s (if (symbolp str)(symbol-name str) str)))
    (save-excursion
      (while (and
              (not (null (string-match "^\\( \\|\f\\|\t\\|\n\\)" s)))
              (> (length s) (string-match "^\\( \\|\f\\|\t\\|\n\\)" s)))
        (setq s (replace-match "" t nil s)))
      (while (and
              (not (null (string-match "\\( \\|\f\\|\t\\|\n\\)$" s)))
              (> (length s) (string-match "\\( \\|\f\\|\t\\|\n\\)$" s)))
        (setq s (replace-match "" t nil s))))
    s))

(defun p-current-file-sans-extension ()
  (-> (buffer-file-name)
    (file-name-nondirectory)
    (file-name-sans-extension)))

(defun p-switch-to-top-left-window ()
  (select-window (window-at 1 1)))

(defun eshell/find-file-top-left (fname)
  (interactive)
  (let ((file (concat default-directory fname)))
    (p-switch-to-top-left-window)
    (find-file file)))

(defun p-buffer-with-name (buffer-string)
  (first (--filter (string= buffer-string (buffer-name it))
                   (buffer-list))))

(defun p-run-applescript (sname)
  (shell-command (concat "osascript "
                         user-emacs-directory
                         "opt/scripts/"
                         sname ".scpt")))

(provide 'p-functions)

;;; p-functions.el ends here
