;;; -*- lexical-binding: t -*-

(p-require-package 'ace-jump-mode)

(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key (kbd "C-c C-SPC") 'ace-jump-mode)

(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(provide 'p-ace-jump)

;;; p-ace-jump.el ends here
