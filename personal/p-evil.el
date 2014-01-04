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

(--each '(jabber-chat-mode git-commit-mode)
  (add-to-list 'evil-insert-state-modes it))
(define-key evil-normal-state-map "gx" 'imenu)
(define-key evil-normal-state-map "gd" (kbd "| M-."))
(define-key evil-normal-state-map "gD" (kbd "| M-,"))
(define-key evil-normal-state-map "gn" 'next-error)
(define-key evil-normal-state-map "gN" 'previous-error)
(define-key evil-normal-state-map "Y" "y$")
(define-key evil-normal-state-map "\\" 'evil-repeat-find-char-reverse)
(define-key evil-normal-state-map "|" 'evil-execute-in-emacs-state)
(define-key evil-ex-completion-map (kbd "M-p") (kbd "<up>"))
(define-key evil-ex-completion-map (kbd "M-n") (kbd "<down>"))
(define-key evil-insert-state-map (kbd "C-k") nil)
(evil-define-key 'motion help-mode-map (kbd "<tab>") (kbd "| <tab>"))

(evil-define-key 'normal jabber-roster-mode-map (kbd "RET") 'jabber-roster-ret-action-at-point)
(evil-define-key 'normal jabber-roster-mode-map (kbd "q") (kbd "| q"))

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-exit-visual-state)
(key-chord-define global-map "jk" (kbd "C-g"))
(key-chord-define global-map "xc" 'smex)
(key-chord-define global-map "XC"
                  '(lambda ()
                     (interactive)
                     (let ((current-prefix-arg '(4)))
                       (smex))))

(eval-after-load 'gnus
  '(progn
     (--each (list gnus-summary-mode-map gnus-article-mode-map)
       (define-key it "j" 'gnus-summary-next-unread-article)
       (define-key it "k" 'gnus-summary-prev-unread-article))))

(eval-after-load 'gnus-group
  '(progn
     (define-key gnus-group-mode-map "j" 'gnus-group-next-unread-group)
     (define-key gnus-group-mode-map "k" 'gnus-group-prev-unread-group)))

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
