;;; -*- lexical-binding: t -*-

(require 'p-key-chord)
(require 'p-ace-jump)

(p-require-package 'undo-tree 'gnu)
(p-require-package 'goto-last-change 'melpa)
(p-require-package 'evil)
(p-require-package 'evil-paredit 'melpa)
(p-require-package 'evil-matchit)
(p-require-package 'evil-surround 'melpa)
(p-require-package 'evil-numbers)

(require 'undo-tree)
(require 'evil)
(require 'evil-surround)

(setq evil-default-cursor t
      ; See https://github.com/syl20bnr/spacemacs/issues/99
      undo-tree-enable-undo-in-region nil)

(customize-set-variable 'evil-want-C-u-scroll t)

(setq-default evil-symbol-word-search t
              evil-shift-width 2)

(defun p-set-up-eval-prefix ()
  (define-prefix-command 'p-evil-eval-prefix))

(defun p-evil-complete (arg)
  "Expand wih company mode if available, otherwise hippie-expand."
  (interactive)
  (if company-mode
      (company-complete)
    (hippie-expand arg)))

(defun p-hippie-expand-previous (arg)
  (interactive)
  (when he-tried-table
    (let ((l (length (car he-tried-table))))
      (when (string= (buffer-substring (- (point) l) (point))
                     (car he-tried-table))
        (delete-region (- (point) l) (point))
        (when (cadr he-tried-table)
          (insert (cadr he-tried-table)))
        (setq he-tried-table (cdr he-tried-table))))))

(defmacro p-add-hjkl-bindings (keymap &optional state &rest bindings)
  (declare (indent defun))
  `(evil-add-hjkl-bindings ,keymap ,state
     (kbd "C-f") (lookup-key evil-motion-state-map (kbd "C-f"))
     (kbd "C-b") (lookup-key evil-motion-state-map (kbd "C-b"))
     ,@bindings))

(setq evil-complete-next-func 'p-evil-complete)
(setq evil-complete-previous-func 'p-hippie-expand-previous)

;; HACK for binding TAB and C-i separately
(keyboard-translate ?\C-i ?\H-i)
(define-key evil-motion-state-map (kbd "TAB") nil)
(define-key evil-motion-state-map (kbd "H-i") 'evil-jump-forward)

(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-word-mode)
(define-key evil-normal-state-map (kbd "S-SPC") 'ace-jump-line-mode)
(define-key evil-normal-state-map (kbd "M-S-SPC") 'ace-jump-char-mode)
(define-key evil-normal-state-map "gx" 'imenu)
(define-key evil-normal-state-map "gd" (kbd "| M-."))
(define-key evil-normal-state-map "gD" (kbd "| M-,"))
(define-key evil-normal-state-map "gn" 'next-error)
(define-key evil-normal-state-map "gN" 'previous-error)
(define-key evil-normal-state-map "Y" "y$")
(define-key evil-normal-state-map "\\" 'evil-repeat-find-char-reverse)
(define-key evil-normal-state-map "|" 'evil-execute-in-emacs-state)
(define-key evil-motion-state-map "|" 'evil-execute-in-emacs-state)
(define-key evil-normal-state-map "U" 'universal-argument)
(define-key evil-motion-state-map "U" 'universal-argument)
(define-key evil-ex-completion-map (kbd "M-p") (kbd "<up>"))
(define-key evil-ex-completion-map (kbd "M-n") (kbd "<down>"))
(define-key evil-insert-state-map (kbd "C-k") nil)
(define-key evil-motion-state-map (kbd "<return>") nil)
(define-key evil-motion-state-map (kbd "RET") nil)
(define-key evil-motion-state-map (kbd "SPC") nil)
(define-key evil-normal-state-map (kbd "C-c +") #'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") #'evil-numbers/dec-at-pt)

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-exit-visual-state)
(key-chord-define global-map "jk" (kbd "C-g"))

(--each '(package-menu-mode
          process-menu-mode
          grep-mode
          Man-mode
          magit-process-mode
          diff-mode
          image-mode
          cider-test-report-mode
          xref--xref-buffer-mode)
  (add-to-list 'evil-motion-state-modes it))

(evil-mode 1)
(global-evil-surround-mode 1)

(provide 'p-evil)

;;; p-evil.el ends here
