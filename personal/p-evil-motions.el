;;; -*- lexical-binding: t -*-

(require 'p-evil)

(evil-define-motion p-forward-sexp (count)
  :type exclusive
  (interactive "<c>")
  (let ((forward-sexp-fn
         (or (get major-mode 'forward-sexp-fn) 'forward-sexp)))
    (funcall forward-sexp-fn count)
    (when (and (eolp) (not (= (point) (point-max))))
      (forward-line)
      (beginning-of-line))))

(evil-define-motion p-backward-sexp (count)
  :type exclusive
  (interactive "<c>")
  (let ((backward-sexp-fn
         (or (get major-mode 'backward-sexp-fn) 'backward-sexp)))
    (funcall backward-sexp-fn count)))

(evil-define-text-object p-evil-whole-buffer (count &optional beg end type)
  "Select whole buffer."
  (list (buffer-end -1) (buffer-end 1)))

(define-key evil-normal-state-map (kbd "M-l") 'p-forward-sexp)
(define-key evil-normal-state-map (kbd "M-h") 'p-backward-sexp)

(evil-define-key 'normal evil-paredit-mode-map "D" 'paredit-kill)
(evil-define-key 'normal evil-paredit-mode-map "C" "Di")
(evil-define-key 'normal evil-paredit-mode-map "Y"
  '(lambda ()
     (interactive)
     (save-excursion
       (execute-kbd-macro "DP"))))

(define-key evil-outer-text-objects-map "h" 'p-evil-whole-buffer)
(define-key evil-inner-text-objects-map "h" 'p-evil-whole-buffer)

(provide 'p-evil-motions)

;;; p-evil-motions.el ends here
