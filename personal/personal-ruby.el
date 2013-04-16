;;; -*- lexical-binding: t -*-
(personal-require-package 'starter-kit-ruby)
(personal-require-package 'ruby-end 'melpa)
(personal-require-package 'ruby-tools 'melpa)
(personal-require-package 'ruby-compilation 'melpa)
(personal-require-package 'rinari 'melpa)
(personal-require-package 'rvm)
(personal-require-package 'mmm-mode 'melpa)
(personal-require-package 'haml-mode 'melpa)

(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.watchr$" . ruby-mode))

;; workaround for bug in starter-kit-ruby
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

;; hooks
(defun set-up-ruby-mode ()
  (ruby-end-mode 1)
  (ruby-tools-mode 1)
  (electric-pair-mode 1))

(add-hook 'ruby-mode-hook 'set-up-ruby-mode)

(defun set-up-inf-ruby-mode ()
  (ruby-tools-mode 1)
  (setq comint-process-echoes t))

(defun personal-ruby-send-buffer ()
  (interactive)
  (ruby-send-region (buffer-end 0) (buffer-end 1)))

(defun personal-rinari-guard ()
  (interactive)
  (let ((default-directory (rinari-root)))
    (make-comint "guard" "bundle" nil "exec" "guard")))

(add-hook 'inf-ruby-mode-hook 'set-up-inf-ruby-mode)

;; rvm
(setq ruby-compilation-executable (expand-file-name "~/.rvm/bin/ruby"))
(setq ruby-compilation-executable-rake (expand-file-name "~/.rvm/bin/rake"))
(rvm-use-default)

;; erb
(require 'mmm-auto)

(setq mmm-global-mode 'auto)

(mmm-add-mode-ext-class 'html-erb-mode "\\.html\\.erb\\'" 'erb)
(mmm-add-mode-ext-class 'html-erb-mode "\\.jst\\.ejs\\'" 'ejs)
(mmm-add-mode-ext-class 'html-erb-mode nil 'html-js)
(mmm-add-mode-ext-class 'html-erb-mode nil 'html-css)

(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . html-erb-mode))
(add-to-list 'auto-mode-alist '("\\.jst\\.ejs\\'"  . html-erb-mode))

;; Keybindings
(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map
       (kbd "C-c C-c")
       'personal-ruby-send-buffer)))

(eval-after-load 'haml-mode
  '(progn
     (define-key haml-mode-map (kbd "RET") 'newline-and-indent)))

(provide 'personal-ruby)
