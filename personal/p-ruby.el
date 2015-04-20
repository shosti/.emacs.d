;;; -*- lexical-binding: t -*-

;;; p-ruby.el --- Personal ruby bindings
;;; Commentary:
;;; Code:
(p-require-package 'ruby-tools)
(p-require-package 'ruby-end)
(p-require-package 'ruby-compilation)
(p-require-package 'projectile-rails 'melpa)
(p-require-package 'rbenv 'melpa)
(p-require-package 'inf-ruby)
(p-require-package 'mmm-mode)
(p-require-package 'haml-mode)
(p-require-package 'yaml-mode 'melpa)
(p-require-package 'robe 'melpa)

(require 'p-wacspace)
(require 'p-evil)
(require 'p-projectile)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(--each '("Guardfile\\'"
          "Berksfile\\'"
          "\\.watchr$"
          "Procfile\\'"
          "\\.rake$"
          "\\.thor$"
          "\\.gemspec$"
          "\\.ru$"
          "Rakefile$"
          "Thorfile$"
          "Gemfile$"
          "Capfile$"
          "Vagrantfile$")
  (add-to-list 'auto-mode-alist (cons it 'ruby-mode)))

(p-configure-feature ruby-mode
  (setq ruby-deep-arglist t
        ruby-deep-indent-paren t
        ruby-insert-encoding-magic-comment nil))

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;

(defun p-foreman ()
  (p-compilation-buffer "foreman" "foreman" "start"))

(defun p-guard ()
  (p-compilation-buffer "guard" "bundle" "exec" "guard"))

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
                 (beginning (search-backward-regexp
                             "generate\\|zeus g\\|rails g\\|z g\\|zgm")))
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
(defalias 'eshell/vrc 'p-visit-rails-created)

;;;;;;;;;;;;;;;;;;;;;;
;; Hooks and Config ;;
;;;;;;;;;;;;;;;;;;;;;;

(setq rbenv-executable "/usr/local/bin/rbenv"
      rbenv-show-active-ruby-in-modeline nil)

(global-rbenv-mode)
(rbenv-use-global)

(defun p-turn-off-robe-complete ()
  (setq-local completion-at-point-functions
              (delq 'robe-complete-at-point
                    completion-at-point-functions)))

(defun p-set-up-ruby-mode ()
  (setq-local tab-width 2)
  (ruby-end-mode 1)
  (eldoc-mode 0)
  (ruby-tools-mode 1)
  (electric-indent-mode 1)
  (electric-pair-mode 1))

(add-hook 'ruby-mode-hook 'p-set-up-ruby-mode)

(defun p-run-remote-pry (&rest args)
  (interactive)
  (let ((buffer (apply 'wacs-make-comint "pry-remote" "pry-remote" nil args)))
    (switch-to-buffer buffer)
    (setq-local comint-process-echoes t)))

;; TODO: debug for different modes
(p-set-leader-key "d" 'p-run-remote-pry)

(defun p-set-up-haml-mode ()
  (eldoc-mode 0))

(add-hook 'haml-mode-hook 'p-set-up-haml-mode)

(defun p-set-up-inf-ruby-mode ()
  (ruby-tools-mode 1)
  (setq comint-process-echoes t))

(defun p-ruby-send-buffer ()
  (interactive)
  (ruby-send-region (buffer-end 0) (buffer-end 1)))

(add-hook 'inf-ruby-mode-hook 'p-set-up-inf-ruby-mode)

(add-hook 'projectile-mode-hook 'projectile-rails-on)

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

(p-configure-feature ruby-mode
  (define-key ruby-mode-map
    (kbd "C-c C-c")
    'p-ruby-send-buffer))

(add-to-list 'auto-mode-alist '("\\.hamlc\\'" . haml-mode))

(p-configure-feature haml-mode
  (define-key haml-mode-map (kbd "RET") 'newline-and-indent))

(put 'ruby-mode 'forward-sexp-fn 'ruby-forward-sexp)
(put 'ruby-mode 'backward-sexp-fn 'ruby-backward-sexp)

;;;;;;;;;;;;;;;;;
;; Workarounds ;;
;;;;;;;;;;;;;;;;;

;; Bug in starter-kit-ruby
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

(provide 'p-ruby)

;;; p-ruby.el ends here
