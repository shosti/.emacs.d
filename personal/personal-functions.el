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

(defun personal-path-from-file (fpath)
  "Reads a :-delineated path file and adds
it to exec-path and the PATH variable"
  (with-temp-buffer
    (insert-file-contents fpath)
    (setq exec-path
          (append (mapcar 'personal-chomp (split-string (buffer-string) ":" t))
                  exec-path))
    (setenv "PATH" (mapconcat 'identity exec-path ":"))))

(defun personal-chomp (str)
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

(provide 'personal-functions)
