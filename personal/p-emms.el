(require 'p-leader)
(require 'p-evil)

(setq emms-info-functions '(emms-info-mpd)
      emms-player-list '(emms-player-mpd))

(autoload 'emms "emms" nil t nil)

(p-configure-feature emms
  (require 'emms-setup)
  (require 'emms-player-simple)
  ;; Minor hack to support spotify playlists. Due to dumbness, it
  ;; needs to be defined before the mpd player is loaded.
  (setq emms-player-mpd-supported-regexp
        (concat "\\`spotify:\\|\\`http://\\|"
                (emms-player-simple-regexp
                 "m3u" "ogg" "flac" "mp3" "wav" "mod" "au" "aiff")))
  (require 'emms-player-mpd)
  (require 'emms-mode-line)

  (p-add-hjkl-bindings emms-playlist-mode-map)
  (emms-mode-line 1)
  (emms-standard)
  (emms-player-mpd-connect))

(defun p-open-mopidy ()
  (interactive)
  (browse-url "http://localhost:6680/moped"))

(p-set-leader-key
  "Mm" #'emms
  "Mp" #'emms-pause
  "Mn" #'emms-next
  "MN" #'emms-previous
  "Me" #'p-open-mopidy)

(provide 'p-emms)

;;; p-emms.el ends here
