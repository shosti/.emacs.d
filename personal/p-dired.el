;;; -*- lexical-binding: t -*-

(require 'p-evil)
(require 'p-discover)
(require 'p-org)
(require 'dired)
(require 'dired-x)

(with-eval-after-load 'dired-x
  (evil-define-key 'normal dired-mode-map (kbd "?")
    'makey-key-mode-popup-dired)
  (define-key dired-mode-map (kbd "M-o") nil)
  (define-key dired-mode-map (kbd "C-x o") 'dired-omit-mode)
  (add-hook 'dired-mode-hook #'p-dired-setup))

(defun p-dired-setup ()
  (define-key dired-mode-map
    (kbd "C-c C-x a")
    #'org-attach-dired-to-subtree)
  (turn-on-gnus-dired-mode))

(provide 'p-dired)

;;; p-dired.el ends here
