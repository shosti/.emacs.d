;;; -*- lexical-binding: t -*-

(require 'p-evil)
(require 'p-discover)
(require 'dired)
(require 'dired-x)

(with-eval-after-load 'dired-x
  (evil-define-key 'normal dired-mode-map (kbd "?")
    'makey-key-mode-popup-dired)
  (define-key dired-mode-map (kbd "M-o") nil)
  (define-key dired-mode-map (kbd "C-x o") 'dired-omit-mode))

(provide 'p-dired)

;;; p-dired.el ends here
