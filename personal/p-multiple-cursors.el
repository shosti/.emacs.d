;;; -*- lexical-binding: t -*-

(p-require-package 'multiple-cursors)

(setq mc/list-file (concat p-private-dir "/.mc-lists.el"))

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

(defadvice mc/mark-next-like-this (around evil-hack activate)
  (let ((evil-visual-char 'exclusive)
        (evil-move-cursor-back nil))
    ad-do-it))

(defadvice mc/mark-previous-like-this (around evil-hack activate)
  (let ((evil-visual-char 'exclusive))
    ad-do-it))

(provide 'p-multiple-cursors)
