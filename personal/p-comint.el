;;; -*- lexical-binding: t -*-

(require 'comint)
(require 'p-evil)

(setq comint-scroll-to-bottom-on-input t
      comint-scroll-to-bottom-on-output t
      comint-scroll-show-maximum-output nil)

(define-key comint-mode-map (kbd "C-a") 'comint-bol)
(define-key comint-mode-map (kbd "<M-return>") nil)
(define-key comint-mode-map (kbd "<S-return>") 'comint-accumulate)
(define-key comint-mode-map (kbd "M-p")
  'comint-previous-matching-input-from-input)
(define-key comint-mode-map (kbd "M-n")
  'comint-next-matching-input-from-input)

(defun p-comint-clear-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(evil-define-key 'normal comint-mode-map
  (kbd "M-k") 'p-comint-clear-buffer)

(provide 'p-comint)
