;;; -*- lexical-binding: t -*-

(require 'p-darwin)

(defconst full-height 53)
(defconst thin-width 82)
(defconst at-top 22)

(defun p-set-up-fonts ()
  ;; Source code pro
  (add-to-list 'default-frame-alist '(font . "Source Code Pro-14"))
  ;; Use Cambria Math as a fallback for math symbols
  (set-fontset-font t 'symbol (font-spec :name "Cambria Math" :size 11.8))
  ;; Source Code Pro has good Greek support and most of the equality
  ;; operators, plus a few other symbols
  (--each (list 'greek
                ;; equality
                (cons (decode-char 'ucs #x2260)                      ; ≠
                      (decode-char 'ucs #x2265))                     ; ≥
                ;; subscript
                (cons (decode-char 'ucs #x2080)                      ; ₀
                      (decode-char 'ucs #x2084))                     ; ₄
                ;; sum/product
                (cons (decode-char 'ucs #x220f)                      ; ∏
                      (decode-char 'ucs #x221a))                     ; √
                (decode-char 'ucs #x2026))                           ; …
    (set-fontset-font t it "Source Code Pro-14"))

  ;; A smattering of other symbols require Symbola
  (--each '(#x2025                                                   ; ‥
            #x2218                                                   ; ∘
            #x2987                                                   ; ⦇
            #x2988                                                   ; ⦈
            #x29f5                                                   ; ⧵
            #x29fa                                                   ; ⧺
            #x29fb                                                   ; ⧻
            #x2a75                                                   ; ⩵
            #x2a76                                                   ; ⩶
            #x2af4)                                                  ; ⫴
    (set-fontset-font t (decode-char 'ucs it) "Symbola-14"))

  ;; triangles
  (set-fontset-font t (cons (decode-char 'ucs #x25b2)                ; ▲
                            (decode-char 'ucs #x25c5)) "Symbola-14") ; ◅

  ;; emoji!
  (--each (list
           ;; Pictographs
           (cons (decode-char 'ucs #x1f300)                          ; 🌀
                 (decode-char 'ucs #x1f5ff))                         ; 🗿

           ;; Emoticons
           (cons (decode-char 'ucs #x1f600)                          ; 😀
                 (decode-char 'ucs #x1f64f))                         ; 🙏

           ;; Transport symbols
           (cons (decode-char 'ucs #x1f680)                          ; 🚀
                 (decode-char 'ucs #x1f6ff))

           ;; Misc symbol
           (cons (decode-char 'ucs #x2600)                           ; ☀
                 (decode-char 'ucs #x26ff))                          ; ⛿

           ;; Dingbats
           (cons (decode-char 'ucs #x2700)                           ; ✀
                 (decode-char 'ucs #x27bf)))                         ; ➿
    (set-fontset-font t it (font-spec :name "Apple Color Emoji"
                                      :size 10))))

(p-set-up-fonts)
(add-to-list 'default-frame-alist `(height . ,full-height))
(add-to-list 'default-frame-alist '(width . 155))

(tool-bar-mode 0)
(setq-default frame-background-mode 'dark)
(scroll-bar-mode 0)
(menu-bar-mode 1)

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
