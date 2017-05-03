;;; -*- lexical-binding: t -*-

(require 'ess-site nil 'noerror)

(require 'p-evil)

(add-to-list 'evil-motion-state-modes 'ess-help-mode)

(with-eval-after-load 'ess-inf
  (define-key inferior-ess-mode-map (kbd "_") nil))

;;;;;;;;;;;
;; HACKS ;;
;;;;;;;;;;;

;; WHY DO SO MANY INFERIOR MODES INSIST ON SCROLLING TO THE
;; BOTTOM?????
(with-eval-after-load 'ess-mode
  (defadvice inferior-ess-input-sender (after recenter activate)
    (recenter)))

(provide 'p-ess)

;;; p-ess.el ends here
