;; -*- lexical-binding: t -*-

(require 'p-darwin)

(defconst full-height 53)
(defconst thin-width 82)
(defconst at-top 22)
(defvar main-font (if (eq system-type 'gnu/linux)
                      "Droid Sans Mono Slashed-11"
                      "Droid Sans Mono Slashed-12"))
(defvar symbola-font (if (eq system-type 'gnu/linux)
                         (font-spec :name "Symbola" :size 15)
                       "Symbola-14"))

(defun p-set-up-fonts ()
  ;; Source code pro
  (add-to-list 'default-frame-alist (cons 'font main-font))
  ;; Use Cambria Math as a fallback for math symbols
  (set-fontset-font t 'symbol symbola-font)
  ;; Droid Sans Mono has good Greek support and most of the equality
  ;; operators, plus a few other symbols
  (--each (list 'greek
                #x2014
                ;; curly-quotes
                (cons (decode-char 'ucs #x2018)                      ; ‘
                      (decode-char 'ucs #x201d))                     ; ”
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
    (set-fontset-font t it main-font))

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
            #x2af4                                                   ; ⫴
            #x2502
            #x2570
            #x251c)
    (set-fontset-font t (decode-char 'ucs it) symbola-font))

  ;; triangles
  (set-fontset-font t (cons (decode-char 'ucs #x25b2)                ; ▲
                            (decode-char 'ucs #x25c5)) symbola-font)); ◅

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

;; Keybindings

(global-set-key (kbd "C-c s") 'p-rotate-windows)

(provide 'p-display)

;;; p-display.el ends here
