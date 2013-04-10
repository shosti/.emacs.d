;;; -*- lexical-binding: t -*-

(require 'personal-options)

(defadvice gnus (before load-passwords activate)
  (personal-load-password-file))

(setq user-mail-address "emanuel.evans@gmail.com")
(setq user-full-name "Emanuel Evans")

(setq gnus-select-method '(nntp "news.gmane.org"))

(provide 'personal-gnus)
