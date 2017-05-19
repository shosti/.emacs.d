(require 'p-leader)

(with-eval-after-load 'term
  ;; Term seems to hate evil-mode
  (setq evil-insert-state-modes (delq 'term-mode evil-insert-state-modes))
  (add-to-list 'evil-emacs-state-modes 'term-mode)
  (key-chord-define term-mode-map "jk" nil)

  ;; Hack on top of a hack
  (define-key term-mode-map (kbd "H-i") #'p-term-tab))

(defun p-term (arg)
  "A variety of hacks for ansi-term."
  (interactive "P")
  (let ((default-directory "~")
        (buffer-name (cond ((numberp arg)
                            (concat "*term*<" (number-to-string arg) ">")))))
    (ansi-term explicit-shell-file-name buffer-name)))

(defun p-term-tab ()
  "Send a TAB signal."
  (interactive
   (term-send-raw-string (kbd "C-i"))))

(p-set-leader-key (kbd "C-z") 'p-term)

(provide 'p-term)
