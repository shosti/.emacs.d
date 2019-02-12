;;; -*- lexical-binding: t -*-
(require 'p-leader)
(require 'p-evil)
(require 's)

(with-eval-after-load 'emms
  (require 'emms-setup)
  (emms-all)
  (p-add-hjkl-bindings emms-playlist-mode-map 'emacs)
  (setq emms-player-list '(emms-player-mpd)
        emms-info-functions '(emms-info-mpd)
        emms-browser-track-sort-function #'emms-sort-natural-order-less-p)

  (setq emms-player-mpd-music-directory "/mnt/media/Media/Music")

  (add-hook 'emms-browser-mode-hook #'p-set-up-emms-browser-mode)

  ;; Horrible bug where disc numbers don't get parsed; here's a hack to get around it until it's fixed
  (defun emms-info-mpd-process (track info)
    (dolist (data info)
      (let ((name (car data))
            (value (cdr data)))
        (setq name (cond ((string= name "artist") 'info-artist)
                         ((string= name "composer") 'info-composer)
                         ((string= name "performer") 'info-performer)
                         ((string= name "title") 'info-title)
                         ((string= name "album") 'info-album)
                         ((string= name "track") 'info-tracknumber)
                         ((string= name "date") 'info-year)
                         ((string= name "genre") 'info-genre)
                         ((string= name "disc") 'info-discnumber)
                         ((string= name "time")
                          (setq value (string-to-number value))
                          'info-playing-time)
                         (t nil)))
        (when name
          (emms-track-set track name value)))))
  )

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
