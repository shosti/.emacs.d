;;; -*- lexical-binding: t -*-

(require 'p-evil)

(add-to-list 'evil-emacs-state-modes 'mingus-playlist-mode)
(add-to-list 'evil-emacs-state-modes 'mingus-browse-mode)
(add-to-list 'evil-motion-state-modes 'mingus-help-mode)

(p-set-leader-key
  "Mm" #'mingus
  "Mp" #'mingus-toggle
  "Mb" #'mingus-browse)

(provide 'p-mingus)

;;; p-mingus.el ends here
