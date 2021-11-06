;; -*- lexical-binding: t -*-

(require 'p-darwin)

(defconst full-height 53)
(defconst thin-width 82)
(defconst at-top 22)
(defvar main-font "Fira Code-12")
(defvar symbola-font (if (eq system-type 'gnu/linux)
                         (font-spec :name "Symbola" :size 15)
                       "Symbola-14"))

(defun p-set-up-fonts ()
  ;; Source code pro
  (add-to-list 'default-frame-alist (cons 'font main-font))
  ;; EMOJI 💥💥💥
  (set-fontset-font t 'symbol "Noto Color Emoji" nil 'append))

(add-to-list 'default-frame-alist `(height . ,full-height))
(add-to-list 'default-frame-alist '(width . 155))
(p-set-up-fonts)

(defun p-frame-set-up-fonts (frame)
  (select-frame frame)
  (p-set-up-fonts))

(add-hook 'after-make-frame-functions #'p-frame-set-up-fonts)

(tool-bar-mode 0)
(setq-default frame-background-mode 'dark)
(scroll-bar-mode 0)
(menu-bar-mode 0)

(when (boundp 'mouse-wheel-scroll-amount)
  (setq mouse-wheel-scroll-amount '(0.01)))

(defun p-full-screen-params ()
  '((fullscreen . fullboth)))

(defun p-display-fill-screen ()
  (interactive)
  (modify-frame-parameters (car (frame-list))
                           (p-full-screen-params)))

(defun p-display-left-half ()
  (interactive)
  (modify-frame-parameters (car (frame-list))
                           `((fullscreen . nil)
                             (top . ,at-top)
                             (left . 0)
                             (height . ,full-height)
                             (width . ,thin-width))))

(frame-parameter nil 'width)

(defun p-display-right-half ()
  (interactive)
  (modify-frame-parameters (car (frame-list))
                           `((fullscreen . nil)
                             (top . ,at-top)
                             (left . 587)
                             (height . ,full-height)
                             (width . ,thin-width))))

(provide 'p-display)

;;; p-display.el ends here
