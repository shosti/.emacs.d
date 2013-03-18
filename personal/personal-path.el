;;; -*- lexical-binding: t -*-

(defun personal-path-from-file (fpath)
  "Reads a :-delineated path file and adds
it to exec-path and the PATH variable"
  (with-temp-buffer
    (insert-file-contents fpath)
    (setq exec-path
          (append (mapcar 'personal-chomp (split-string (buffer-string) ":" t))
                  exec-path))
    (setenv "PATH" (mapconcat 'identity exec-path ":"))))

(personal-path-from-file "~/.path")

(provide 'personal-path)
