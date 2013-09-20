(defun p-load-ess ()
  (interactive)
  (let ((ess-lib (concat user-emacs-directory "opt/ess/lisp")))
    (when (file-exists-p ess-lib)
      (unless (-contains? load-path ess-lib)
        (add-to-list 'load-path ess-lib)
        (require 'ess-site)))))

(provide 'p-ess)

;;; p-ess.el ends here
