(require 'p-key-chord)

(p-require-package 'evil 'melpa)
(p-require-package 'evil-paredit 'melpa)
(p-require-package 'evil-matchit)
(p-require-package 'surround)
(p-require-package 'goto-chg 'melpa)

(require 'evil)
;(require 'surround)

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

(defun p-set-up-evil-leader ()
  (define-prefix-command 'p-leader-map)
  (define-key p-leader-map "w" 'wacs-prefix-map)
  (define-key p-leader-map "ee" 'p-evil-eval-last-sexp)
  (define-key p-leader-map "eb" 'eval-buffer)
  (define-key p-leader-map "E" (kbd "\\ C-M-x"))
  (define-key p-leader-map "m" 'magit-blame-mode)
  (define-key p-leader-map "n" 'esk-cleanup-buffer)
  (define-key p-leader-map "g" 'magit-status)
  (define-key p-leader-map "G" 'git-gutter)
  (define-key p-leader-map "f" 'ido-find-file)
  (define-key p-leader-map "l" 'p-find-personal-file)
  (define-key p-leader-map "b" 'helm-for-files)
  (define-key p-leader-map "B" 'ido-switch-buffer)
  (define-key p-leader-map "a" 'ag-project)
  (define-key p-leader-map "z" 'eshell)
  (define-key p-leader-map "Z" 'shell)
  (define-key p-leader-map "p" 'projectile-prefix-map)
  (define-key p-leader-map "P" 'p-send-to-pianobar)
  (define-key p-leader-map "u" 'undo-tree-visualize)
  (define-key p-leader-map "k" 'ido-kill-buffer)
  (define-key p-leader-map "K" 'p-delete-current-buffer-file)
  (define-key p-leader-map "j" 'p-hipchat-switch-to-room))

(p-set-up-evil-leader)
(key-chord-define evil-normal-state-map ",." 'p-leader-map)
(define-key evil-normal-state-map " " 'ace-jump-mode)

(--each '(jabber-chat-mode git-commit-mode)
  (add-to-list 'evil-insert-state-modes it))
(define-key evil-normal-state-map "gx" 'imenu)
(define-key evil-normal-state-map "gd" (kbd "\\ M-."))
(define-key evil-normal-state-map "gD" (kbd "\\ M-,"))
(define-key evil-normal-state-map "gn" 'next-error)
(define-key evil-normal-state-map "gN" 'previous-error)
(define-key evil-normal-state-map "Y" "y$")
(define-key evil-insert-state-map (kbd "C-k") nil)
(evil-define-key 'motion help-mode-map (kbd "<tab>") (kbd "\\ <tab>"))

(evil-define-key 'normal jabber-roster-mode-map (kbd "RET") 'jabber-roster-ret-action-at-point)
(evil-define-key 'normal jabber-roster-mode-map (kbd "q") (kbd "\\ q"))

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-exit-visual-state)
(key-chord-define global-map "jk" (kbd "C-g"))
(key-chord-define global-map ",." 'p-leader-map)
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

(defmacro p-add-hjkl-bindings (mode)
  `(evil-add-hjkl-bindings ,mode
     "h" (lookup-key evil-motion-state-map "h")
     "h" (lookup-key evil-motion-state-map "h")
     "h" (lookup-key evil-motion-state-map "h")
     "/" ()))

(evil-add-hjkl-bindings magit-blame-map)


(evil-mode 1)
;(global-surround-mode 1)

(provide 'p-evil)

;;; p-evil.el ends here
