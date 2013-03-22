;;; -*- lexical-binding: t -*-

(defconst full-height 53)
(defconst full-width 155)

(add-to-list 'default-frame-alist '(font . "Consolas-14"))
(add-to-list 'default-frame-alist '(height . 53))
(add-to-list 'default-frame-alist '(width . 155))

(setq-default cursor-type 'bar)
(tool-bar-mode 0)
(setq-default frame-background-mode 'dark)
(blink-cursor-mode 1)
(scroll-bar-mode 1)
(menu-bar-mode 1)
(setq)

(when (boundp 'mouse-wheel-scroll-amount)
  (setq mouse-wheel-scroll-amount '(0.01)))

(defun display-fill-screen ()
  (interactive)
  (modify-frame-parameters (car (frame-list))
                           '((top . 22)
                             (left . 0)
                             (height . 53)
                             (width . 155))))

(defun display-left-half ()
  (interactive)
  (modify-frame-parameters (car (frame-list))
                           '((top . 22)
                             (left . 0)
                             (height . 53)
                             (width . 82))))

(defun display-right-half ()
  (interactive)
  (modify-frame-parameters (car (frame-list))
                           '((top . 22)
                             (left . 582)
                             (height . 53)
                             (width . 82))))

(provide 'personal-display)
