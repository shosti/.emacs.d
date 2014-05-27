;;; -*- lexical-binding: t -*-

(require 'p-key-chord)

(p-require-package 'evil 'melpa)
(p-require-package 'evil-paredit 'melpa)
(p-require-package 'evil-matchit)
(p-require-package 'surround 'melpa)
(p-require-package 'goto-chg)

(require 'evil)
(require 'surround)

(setq evil-default-cursor t
      evil-lookup-func 'dash-at-point)

(setq-default evil-symbol-word-search t
              evil-shift-width 2)

(defmacro with-emacs-state (&rest cmds)
  `(progn
     (evil-emacs-state)
     ,@cmds
     (evil-normal-state)))

(defun p-set-up-eval-prefix ()
  (define-prefix-command 'p-evil-eval-prefix))

(defun p-evil-eval-last-sexp ()
  (interactive)
  (save-excursion
    (with-emacs-state
     (forward-char)
     (execute-kbd-macro (kbd "C-x C-e")))))

;; HACK for binding TAB and C-i separately
(keyboard-translate ?\C-i ?\H-i)
(define-key evil-motion-state-map (kbd "TAB") nil)
(define-key evil-motion-state-map (kbd "H-i") 'evil-jump-forward)

(define-key evil-normal-state-map " " 'ace-jump-mode)
(define-key evil-normal-state-map "gx" 'imenu)
(define-key evil-normal-state-map "gd" (kbd "| M-."))
(define-key evil-normal-state-map "gD" (kbd "| M-,"))
(define-key evil-normal-state-map "gn" 'next-error)
(define-key evil-normal-state-map "gN" 'previous-error)
(define-key evil-normal-state-map "Y" "y$")
(define-key evil-normal-state-map "\\" 'evil-repeat-find-char-reverse)
(define-key evil-normal-state-map "|" 'evil-execute-in-emacs-state)
(define-key evil-motion-state-map "|" 'evil-execute-in-emacs-state)
(define-key evil-ex-completion-map (kbd "M-p") (kbd "<up>"))
(define-key evil-ex-completion-map (kbd "M-n") (kbd "<down>"))
(define-key evil-insert-state-map (kbd "C-k") nil)
(define-key evil-motion-state-map (kbd "<return>") nil)
(define-key evil-motion-state-map (kbd "RET") nil)
(define-key evil-motion-state-map (kbd "SPC") nil)

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-exit-visual-state)
(key-chord-define global-map "jk" (kbd "C-g"))

(--each '(package-menu-mode process-menu-mode grep-mode)
  (add-to-list 'evil-motion-state-modes it))

(evil-mode 1)
(global-surround-mode 1)

(provide 'p-evil)

;;; p-evil.el ends here
