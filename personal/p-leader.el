(require 'p-key-chord)
(require 'p-evil)

(define-prefix-command 'p-leader-map)

(defun p-set-leader-key (&rest bindings)
  (--each (-partition 2 bindings)
    (define-key p-leader-map (car it) (cadr it))))

(p-set-leader-key
 "ee" 'p-evil-eval-last-sexp
 "eb" 'eval-buffer
 "E" (kbd "\\ C-M-x")
 "n" 'esk-cleanup-buffer
 "l" 'p-find-personal-file
 "r" 'p-rename-current-buffer-file
 "K" 'p-delete-current-buffer-file)

(key-chord-define global-map ",." 'p-leader-map)

(provide 'p-leader)

;;; p-leader.el ends here
