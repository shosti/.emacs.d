;;; -*- lexical-binding: t -*-
(require 'p-leader)
(require 'p-evil)
(require 's)

(with-eval-after-load 'emms
  (require 'emms-setup)
  (emms-all)
  (p-add-hjkl-bindings emms-playlist-mode-map 'emacs)
  (add-to-list 'evil-motion-state-modes 'emms-browser-mode)
  (setq emms-player-list '(emms-player-mpd)
        emms-info-functions '(emms-info-mpd))

  (setq emms-player-mpd-music-directory "/mnt/media/Media/Music"))

(p-set-leader-key
  "Mm" #'emms
  "Mb" #'emms-smart-browse
  "Ma" #'emms-browse-by-album
  "MA" #'emms-browse-by-artist
  "Mp" #'emms-pause
  "Mn" #'emms-next
  "MN" #'emms-previous
  "Mg" #'emms-player-mpd-connect)

(provide 'p-emms)

;;; p-emms.el ends here
