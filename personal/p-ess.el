(add-to-list 'load-path (concat user-emacs-directory "opt/ess"))
(load-library "ess-autoloads")

;;;;;;;;;;;
;; HACKS ;;
;;;;;;;;;;;

;; WHY DO SO MANY INFERIOR MODES INSIST ON SCROLLING TO THE
;; BOTTOM?????
(eval-after-load 'ess-mode
  '(progn
     (defadvice inferior-ess-input-sender (after recenter activate)
       (recenter))))

(provide 'p-ess)

;;; p-ess.el ends here
