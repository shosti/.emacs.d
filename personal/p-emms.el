;;; -*- lexical-binding: t -*-
(require 'p-leader)
(require 'p-evil)
(require 's)

(require 'emms-auto)

(with-eval-after-load 'emms
  (require 'emms-setup)
  (emms-all)
  (p-add-hjkl-bindings emms-playlist-mode-map 'emacs)
  (setq emms-player-list '(emms-player-mpd)
        emms-info-functions '(emms-info-mpd)
        emms-browser-track-sort-function #'emms-sort-natural-order-less-p)

  (setq emms-player-mpd-music-directory "/mnt/media/Media/Music")

  (add-hook 'emms-browser-mode-hook #'p-set-up-emms-browser-mode))

(defun p-set-up-emms-browser-mode ()
  (evil-motion-state 1))

(p-set-leader-key
  "Mm" #'emms
  "Mb" #'emms-smart-browse
  "Ma" #'emms-browse-by-album
  "MA" #'emms-browse-by-artist
  "Mp" #'emms-pause
  "Mn" #'emms-next
  "MN" #'emms-previous
  "Mg" #'emms-player-mpd-connect
  "MG" #'emms-cache-set-from-mpd-all)

(provide 'p-emms)

;;; p-emms.el ends here
