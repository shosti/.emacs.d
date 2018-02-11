;;; -*- lexical-binding: t -*-
(require 'p-leader)
(require 'p-evil)
(require 's)

(setq emms-source-file-default-directory (expand-file-name "~/Music"))

(with-eval-after-load 'emms
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)
  (p-add-hjkl-bindings emms-playlist-mode-map 'emacs))

(p-set-leader-key
  "Mm" #'emms
  "Mp" #'emms-pause
  "Mn" #'emms-next
  "MN" #'emms-previous
  "Ma" #'emms-add-url
  "Me" #'p-browse-mopify
  "ME" #'p-browse-moped
  "Mg" #'emms-player-mpd-connect)

(provide 'p-emms)

;;; p-emms.el ends here
