;;; -*- lexical-binding: t -*-
(require 'p-leader)
(require 'p-evil)
(require 's)

(defvar p-emms-mpd-extra-protocols
  '("spotify:" "yt:" "youtube:" "pandora:" "http://"))

(setq emms-info-functions '(emms-info-mpd)
      emms-player-list '(emms-player-mpd))

(autoload 'emms "emms" nil t nil)

(p-configure-feature emms
  (require 'emms-setup)
  (require 'emms-player-mpd)
  (require 'emms-mode-line)

  ;; Minor hack to support spotify and other non-standard playlists.
  (setq emms-player-mpd-supported-regexp
        (concat (s-join "\\|" (mapcar (lambda (protocol)
                                        (concat "\\`" protocol))
                                      p-emms-mpd-extra-protocols))
                "\\|"
                (emms-player-simple-regexp
                 "m3u" "ogg" "flac" "mp3" "wav" "mod" "au" "aiff")))
  (emms-player-set emms-player-mpd
                   'regex emms-player-mpd-supported-regexp)
  (p-add-hjkl-bindings emms-playlist-mode-map 'emacs
    "g" #'emms-player-mpd-connect)
  (emms-mode-line 1)
  (emms-standard)
  (emms-player-mpd-connect))

(defun p-browse-mopify ()
  "Browse mopify web frontend for mopidy."
  (interactive)
  (browse-url "http://localhost:6680/mopify"))

(defun p-browse-moped ()
  "Browse moped web frontend for mopidy."
  (interactive)
  (browse-url "http://localhost:6680/moped"))

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
