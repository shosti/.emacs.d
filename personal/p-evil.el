(require 'p-key-chord)

(p-require-package 'evil 'melpa)
(p-require-package 'evil-paredit 'melpa)
(p-require-package 'evil-matchit)
(p-require-package 'surround 'melpa)
(p-require-package 'goto-chg)

(require 'evil)
(require 'surround)

(setq evil-default-cursor t)

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

(key-chord-define evil-normal-state-map ",." 'p-leader-map)
(define-key evil-normal-state-map " " 'ace-jump-mode)

(--each '(git-commit-mode)
  (add-to-list 'evil-insert-state-modes it))
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
(define-key evil-motion-state-map (kbd "<tab>") nil)
(define-key evil-motion-state-map (kbd "TAB") nil)

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-exit-visual-state)
(key-chord-define global-map "jk" (kbd "C-g"))
(key-chord-define global-map "xc" 'smex)
(key-chord-define global-map "XC"
                  '(lambda ()
                     (interactive)
                     (let ((current-prefix-arg '(4)))
                       (smex))))

(defadvice paredit-mode (after turn-on-evil-paredit activate)
  (require 'evil-paredit)
  (evil-paredit-mode 1))

(defadvice magit-blame-mode (after switch-to-emacs-mode activate)
  (if magit-blame-mode
      (evil-emacs-state 1)
    (evil-normal-state 1)))

(evil-add-hjkl-bindings magit-blame-map)

(add-to-list 'evil-motion-state-modes 'package-menu-mode)

(evil-mode 1)
(global-surround-mode 1)

(provide 'p-evil)

;;; p-evil.el ends here
