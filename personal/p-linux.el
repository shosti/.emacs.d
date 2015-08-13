(defun p-battery-acpi ()
  (let* ((output (shell-command-to-string "acpi"))
         (percent (nth 1 (s-match "\\([0-9]+\\)%" output))))
    (list
     (cons ?p percent)
     (cons ?t (nth 1 (s-match "\\([0-9]+:[0-9]+\\):[0-9]+ \\(remaining\\|until\\)"
                              output)))
     (cons ?b (cond
               ((s-matches-p ": Charging" output) "+")
               ((< (string-to-number percent) 10) "-")
               ((< (string-to-number percent) 5) "!"))))))

(when (eq system-type 'gnu/linux)
  (setq x-super-keysym 'meta
        battery-status-function #'p-battery-acpi))

(provide 'p-linux)

;;; p-linux.el ends here
