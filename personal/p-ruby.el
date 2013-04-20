;;; -*- lexical-binding: t -*-
(p-require-package 'starter-kit-ruby)
(p-require-package 'ruby-end 'melpa)
(p-require-package 'ruby-tools 'melpa)
(p-require-package 'ruby-compilation 'melpa)
(p-require-package 'rinari 'melpa)
(p-require-package 'rvm)
(p-require-package 'mmm-mode 'melpa)
(p-require-package 'haml-mode 'melpa)
(p-require-package 'yaml-mode 'melpa)
(p-require-package 'zossima 'melpa)

(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.watchr$" . ruby-mode))

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;

(defun p-rinari-guard ()
  (interactive)
  (let* ((default-directory (rinari-root))
         (guard-buffer (make-comint "guard" "bundle" nil "exec" "guard")))
    (switch-to-buffer guard-buffer)
    (compilation-shell-minor-mode 1)))

(defun eshell/visit-created ()
  "Visits the last file created by a rails generator in another
window."
  (interactive)
  (save-excursion
    (let* ((line-beginning (search-backward "create "))
           (line-end (line-end-position))
           (fname (--> (buffer-substring line-beginning line-end)
                    (s-split " " it t)
                    (cadr it))))
      (find-file-other-window (concat default-directory fname))))

;;;;;;;;;;;;;;;;;;;;;;
;; Hooks and Config ;;
;;;;;;;;;;;;;;;;;;;;;;

(defun p-set-up-ruby-mode ()
  (rinari-launch)
  (ruby-end-mode 1)
  (ruby-tools-mode 1)
  (electric-pair-mode 1))

(add-hook 'ruby-mode-hook 'p-set-up-ruby-mode)

(defun p-set-up-inf-ruby-mode ()
  (ruby-tools-mode 1)
  (setq comint-process-echoes t))

(defun p-ruby-send-buffer ()
  (interactive)
  (ruby-send-region (buffer-end 0) (buffer-end 1)))

(add-hook 'inf-ruby-mode-hook 'p-set-up-inf-ruby-mode)

(global-rinari-mode 1)

;;;;;;;;;
;; RVM ;;
;;;;;;;;;

(setq ruby-compilation-executable (expand-file-name "~/.rvm/bin/ruby"))
(setq ruby-compilation-executable-rake (expand-file-name "~/.rvm/bin/rake"))
(rvm-use-default)

;;;;;;;;;
;; ERB ;;
;;;;;;;;;

(require 'mmm-auto)

(setq mmm-global-mode 'auto)

(mmm-add-mode-ext-class 'html-erb-mode "\\.html\\.erb\\'" 'erb)
(mmm-add-mode-ext-class 'html-erb-mode "\\.jst\\.ejs\\'" 'ejs)
(mmm-add-mode-ext-class 'html-erb-mode nil 'html-js)
(mmm-add-mode-ext-class 'html-erb-mode nil 'html-css)

(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . html-erb-mode))
(add-to-list 'auto-mode-alist '("\\.jst\\.ejs\\'"  . html-erb-mode))

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map
       (kbd "C-c C-c")
       'p-ruby-send-buffer)))

(eval-after-load 'haml-mode
  '(progn
     (define-key haml-mode-map (kbd "RET") 'newline-and-indent)))

;;;;;;;;;;;;;;;;;
;; Workarounds ;;
;;;;;;;;;;;;;;;;;

;; Bug in starter-kit-ruby
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

(provide 'p-ruby)

;;; p-ruby.el ends here
