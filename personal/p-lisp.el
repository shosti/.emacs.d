;;; -*- lexical-binding: t -*-

(p-require-package 'paredit)
(p-require-package 'clojure-mode)
(p-require-package 'highlight-parentheses)
(p-require-package 'macrostep)
(p-require-package 'redshank 'melpa)

(require 'p-starter-kit-lisp)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(setq redshank-install-lisp-support nil)
(font-lock-add-keywords 'lisp-interaction-mode
                        '(("(\\|)" . 'p-paren-face)))

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;

(defun p-find-personal-file ()
  (interactive)
  (let ((ido-use-filename-at-point nil))
    (ido-find-file-in-dir (concat user-emacs-directory "personal/"))))

;;;;;;;;;;;
;; Hooks ;;
;;;;;;;;;;;

(defun p-remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

(defun p-set-up-lisp-coding ()
  (paredit-mode 1)
  (smartparens-mode 0)
  (local-set-key (kbd "RET") 'paredit-newline)
  (highlight-parentheses-mode))

(defun p-set-up-emacs-lisp-mode ()
  (redshank-mode 1)
  (turn-on-eldoc-mode)
  (elisp-slime-nav-mode)
  (p-remove-elc-on-save))

(add-hook 'emacs-lisp-mode-hook 'p-set-up-emacs-lisp-mode)

(mapc (lambda (hook)
        (add-hook hook 'p-set-up-lisp-coding))
      '(emacs-lisp-mode-hook
        lisp-interaction-mode-hook
        lisp-mode-hook
        clojure-mode-hook
        scheme-mode-hook))

(defun p-set-up-eval-minibuffer ()
  (when (eq this-command 'eval-expression)
    (paredit-mode 1)))

(add-hook 'minibuffer-setup-hook 'p-set-up-eval-minibuffer)

;;;;;;;;;;;;;;;
;; parenface ;;
;;;;;;;;;;;;;;;

(defface p-paren-face
  '((((class color) (background dark))
     (:foreground "grey50"))
    (((class color) (background light))
     (:foreground "grey55")))
  "Face used to dim parentheses."
  :group 'starter-kit-faces)

(cl-dolist (mode '(scheme emacs-lisp lisp))
  (font-lock-add-keywords (intern (concat (symbol-name mode) "-mode"))
                          '(("(\\|)" . 'p-paren-face))))

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-c l") 'p-find-personal-file)
(global-set-key (kbd "C-c t") 'toggle-debug-on-error)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-m") 'macrostep-expand)
(define-key lisp-interaction-mode-map (kbd "C-c C-m") 'macrostep-expand)

(provide 'p-lisp)

;;; p-lisp.el ends here
