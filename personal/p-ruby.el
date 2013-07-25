;;; p-ruby.el --- Personal ruby bindings
;;; Commentary:
;;; Code:
(p-require-package 'starter-kit-ruby)
(p-require-package 'ruby-end 'melpa)
(p-require-package 'ruby-tools 'melpa)
(p-require-package 'ruby-compilation 'melpa)
(p-require-package 'rinari 'melpa)
(p-require-package 'rbenv 'melpa)
(p-require-package 'mmm-mode 'melpa)
(p-require-package 'haml-mode 'melpa)
(p-require-package 'yaml-mode 'melpa)
(p-require-package 'robe 'melpa)

(require 'p-wacspace)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.watchr$" . ruby-mode))
(eval-after-load 'ruby-mode
  '(progn
     (setq ruby-deep-arglist nil
           ruby-deep-indent-paren nil)))

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;

(defun p-rinari-guard ()
  (p-compilation-buffer "guard" "bundle" nil "exec" "guard"))

(defun p-foreman ()
  (p-compilation-buffer "foreman" "foreman" "start"))

(defun p-visit-pow-log ()
  (interactive)
  (find-file (expand-file-name (concat "~/Library/Logs/Pow/apps/"
                                       (wacs-project-name)
                                       ".log")))
  (auto-revert-tail-mode)
  (read-only-mode))

(defun p-visit-rails-created ()
  "Visits the last file created by a rails generator in another
window."
  (interactive)
  (let ((created-files
         (save-excursion
           (let ((end (point))
                 (beginning (search-backward "generate")))
             (->> (buffer-substring-no-properties beginning end)
               (s-split "\n")
               (--map (s-trim it))
               (--filter (string-match "^create" it))
               (--map (cadr (s-split " " it t))))))))
    (when (null created-files)
      (error "No files created"))
    (let ((file
           (concat default-directory
                   (if (= (length created-files) 1)
                       (car created-files)
                     (completing-read "File: "
                                      created-files nil nil nil nil
                                      (car created-files))))))
      (p-switch-to-top-left-window)
      (find-file file))))

(defalias 'vrc 'p-visit-rails-created)

;;;;;;;;;;;;;;;;;;;;;;
;; Hooks and Config ;;
;;;;;;;;;;;;;;;;;;;;;;

(setq rinari-major-modes nil)
(setq rbenv-executable "/usr/local/bin/rbenv"
      rbenv-show-active-ruby-in-modeline nil)
(global-rbenv-mode)
(rbenv-use-global)

(add-to-list 'ac-modes 'haml-mode)

(defun p-set-up-ruby-mode ()
  (robe-mode 1)
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
