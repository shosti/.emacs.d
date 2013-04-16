;;; -*- lexical-binding: t -*-

(setq inferior-octave-startup-file (concat user-emacs-directory ".emacs-octave"))
(setenv "GNUTERM" "x11")
(add-hook 'inferior-octave-mode-hook
          'pretty-mode-on)

(provide 'p-octave)
