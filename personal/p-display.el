;;; -*- lexical-binding: t -*-

(require 'p-darwin)

(add-to-list 'default-frame-alist '(font . "Inconsolata-14"))
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 155))

(setq-default cursor-type 'bar)
(tool-bar-mode 0)
(setq-default frame-background-mode 'dark)
(blink-cursor-mode 1)
(scroll-bar-mode 1)
(menu-bar-mode 1)

(when (boundp 'mouse-wheel-scroll-amount)
  (setq mouse-wheel-scroll-amount '(0.01)))

(defun p-full-screen-params ()
  (if (= (length (p-screens)) 2)
      '((top + -103)
        (left + -1680)
        (height . 67)
        (width . 234))
    '((fullscreen . fullboth))))

(defun p-display-fill-screen ()
  (interactive)
  (modify-frame-parameters (car (frame-list))
                           (p-full-screen-params)))

(defun p-display-left-half ()
  (interactive)
  (modify-frame-parameters (car (frame-list))
                           '((fullscreen . nil)
                             (top . 22)
                             (left . 0)
                             (height . 49)
                             (width . 82))))

(defun p-display-right-half ()
  (interactive)
  (modify-frame-parameters (car (frame-list))
                           '((fullscreen . nil)
                             (top . 22)
                             (left . 666)
                             (height . 49)
                             (width . 82))))

(defun p-rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-c s") 'p-rotate-windows)

(provide 'p-display)
