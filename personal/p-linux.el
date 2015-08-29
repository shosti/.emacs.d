(require 'p-evil)

(defun p-battery-acpi ()
  (let* ((output (shell-command-to-string "acpi"))
         (percent (nth 1 (s-match "\\([0-9]+\\)%" output))))
    (list
     (cons ?p percent)
     (cons ?b (cond
               ((s-matches-p ": Charging" output) "+")
               ((< (string-to-number percent) 10) "-")
               ((< (string-to-number percent) 5) "!")))
     (-when-let (time-remaining
                 (nth 1 (s-match "\\([0-9]+:[0-9]+\\):[0-9]+ \\(remaining\\|until\\)"
                                 output)))
       (cons ?t time-remaining)))))

(defun p-sleep-message ()
  (interactive)
  (message "Sleeping..."))

(defun p-set-up-proced-mode ()
  (visual-line-mode 0))

(when (eq system-type 'gnu/linux)
  (setq x-super-keysym 'meta)
  (global-set-key (kbd "<XF86PowerOff>") #'p-sleep-message)

  (with-eval-after-load 'proced
    (p-add-hjkl-bindings proced-mode-map 'emacs
      "K" #'proced-send-signal
      "/" #'evil-search-forward
      "n" #'evil-search-next
      "N" #'evil-search-backward)
    (add-hook 'proced-mode-hook #'p-set-up-proced-mode)))

(provide 'p-linux)

;;; p-linux.el ends here
