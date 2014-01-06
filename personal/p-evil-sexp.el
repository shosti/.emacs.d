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

(define-key evil-normal-state-map (kbd "M-l") 'p-forward-sexp)
(define-key evil-normal-state-map (kbd "M-h") 'p-backward-sexp)

(evil-define-key 'normal evil-paredit-mode-map "D" 'paredit-kill)
(evil-define-key 'normal evil-paredit-mode-map "C" "Di")
(evil-define-key 'normal evil-paredit-mode-map "Y"
  '(lambda ()
     (interactive)
     (save-excursion
       (execute-kbd-macro "DP"))))

(provide 'p-evil-sexp)

;;; p-evil-sexp.el ends here
