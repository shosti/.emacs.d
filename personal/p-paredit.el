;;; -*- lexical-binding: t -*-

(p-require-package 'paredit)

(require 'p-editing)
(require 'p-evil)
(require 'paredit)

;; Config

;; making paredit work with delete-selection-mode
;; from whattheemacsd
(put 'paredit-forward-delete 'delete-selection 'supersede)
(put 'paredit-backward-delete 'delete-selection 'supersede)
(put 'paredit-open-round 'delete-selection t)
(put 'paredit-open-square 'delete-selection t)
(put 'paredit-doublequote 'delete-selection t)
(put 'paredit-newline 'delete-selection t)

;; Functions

(defun p-paredit-backward-kill-word ()
  "Paredit replacement for backward-kill-word."
  (interactive)
  (if (use-region-p)
      (paredit-kill-region (region-beginning) (region-end))
    (paredit-backward-kill-word)))

(defun paredit-wrap-round-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-round)
  (insert " ")
  (forward-char -1))

;; whattheemacsd stuff
(defun paredit--is-at-start-of-sexp ()
  (and (looking-at "(\\|\\[")
     (not (nth 3 (syntax-ppss))) ;; inside string
     (not (nth 4 (syntax-ppss))))) ;; inside comment

(defun paredit-duplicate-closest-sexp ()
  (interactive)
  ;; skips to start of current sexp
  (while (not (paredit--is-at-start-of-sexp))
    (paredit-backward))
  (set-mark-command nil)
  ;; while we find sexps we move forward on the line
  (while (and (bounds-of-thing-at-point 'sexp)
            (<= (point) (car (bounds-of-thing-at-point 'sexp)))
            (not (= (point) (line-end-position))))
    (forward-sexp)
    (while (looking-at " ")
      (forward-char)))
  (kill-ring-save (mark) (point))
  ;; go to the next line and copy the sexprs we encountered
  (paredit-newline)
  (yank)
  (exchange-point-and-mark))

(defadvice paredit-mode (after turn-on-evil-paredit activate)
  (require 'evil-paredit)
  (evil-paredit-mode 1))

;;;;;;;;;;;;;;
;; Bindings ;;
;;;;;;;;;;;;;;

(define-key paredit-mode-map (kbd "M-)") 'paredit-wrap-round-from-behind)
(define-key paredit-mode-map (kbd "C-w") 'p-paredit-backward-kill-word)

(provide 'p-paredit)

;;; p-paredit.el ends here
