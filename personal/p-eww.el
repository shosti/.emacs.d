(require 'p-evil)

(add-to-list 'evil-motion-state-modes 'eww-mode)

;; Fix horrible eww coloring
(setq shr-color-visible-luminance-min 70)

(with-eval-after-load 'eww-mode
  (evil-define-key 'motion eww-mode-map
    "H" 'eww-back-url
    "L" 'eww-forward-url
    (kbd "SPC") 'ace-jump-char-mode))

(provide 'p-eww)

;;; p-eww.el ends here
