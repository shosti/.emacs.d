;;; -*- lexical-binding: t -*-

(p-require-package 'paredit)
(p-require-package 'clojure-mode)
(p-require-package 'highlight-parentheses)
(p-require-package 'macrostep)
(p-require-package 'elisp-slime-nav)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(setq redshank-install-lisp-support nil)
(font-lock-add-keywords 'lisp-interaction-mode
                        '(("(\\|)" . 'p-paren-face)))
(add-to-list 'auto-mode-alist '("Cask$" . emacs-lisp-mode))

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;

(defun p-find-personal-file ()
  (interactive)
  (let ((ido-use-filename-at-point nil))
    (ido-find-file-in-dir (concat user-emacs-directory "personal/"))))

(defun p-find-private-file ()
  (interactive)
  (let ((ido-use-filename-at-point nil))
    (ido-find-file-in-dir (concat user-emacs-directory "private/"))))

;;;;;;;;;;;
;; Hooks ;;
;;;;;;;;;;;

(defun p-remove-elc ()
  (if (file-exists-p (concat buffer-file-name "c"))
      (delete-file (concat buffer-file-name "c"))))

(defun p-remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook 'p-remove-elc))

(defun p-set-up-lisp-coding ()
  (setq-local tab-width 8)
  (paredit-mode 1)
  (local-set-key (kbd "RET") 'paredit-newline)
  (highlight-parentheses-mode))

(defun p-set-up-emacs-lisp-mode ()
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

(--each '(scheme emacs-lisp lisp)
  (font-lock-add-keywords (intern (concat (symbol-name it) "-mode"))
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
