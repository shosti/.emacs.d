(require 'personal-packages)
(require 'google-c-style)

(defun set-up-cc-mode ()
  (google-set-c-style)
  (c-turn-on-eldoc-mode)
  (electric-indent-mode 1)
  (c-toggle-auto-hungry-state 1)
  (c-toggle-auto-newline 0)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4))

(add-hook 'c-mode-common-hook 'set-up-cc-mode t)
