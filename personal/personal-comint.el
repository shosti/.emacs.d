;;; -*- lexical-binding: t -*-

(require 'comint)

(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-show-maximum-output nil)

(define-key comint-mode-map (kbd "C-a") 'comint-bol)
(define-key comint-mode-map (kbd "<M-return>") nil)
(define-key comint-mode-map (kbd "<S-return>") 'comint-accumulate)

(provide 'personal-comint)
