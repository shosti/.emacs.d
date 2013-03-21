(defun set-up-inf-ruby-mode ()
  (setq comint-process-echoes t))

;; workaround bug in esk-ruby
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

(add-hook 'inf-ruby-mode-hook
          'set-up-inf-ruby-mode)

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-c v") 'ruby-load-file)))

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
