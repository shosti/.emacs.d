;;; -*- lexical-binding: t -*-

(personal-require-package 'starter-kit-ruby)
(personal-require-package 'ruby-end)
(personal-require-package 'rinari)
(personal-require-package 'rvm)
(personal-require-package 'mmm-mode 'melpa)

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-c v") 'ruby-load-file)))

;; workaround for bug in starter-kit-ruby
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

(defun set-up-ruby-mode ()
  (ruby-end-mode 1))

(add-hook 'ruby-mode-hook 'set-up-ruby-mode)

;; rvm
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

(provide 'personal-ruby)
