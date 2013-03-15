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

(provide 'personal-functions)
