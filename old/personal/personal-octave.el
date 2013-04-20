(require 'personal-packages)

(setq inferior-octave-startup-file (concat prelude-personal-dir ".emacs-octave"))
(setenv "GNUTERM" "x11")
(add-hook 'inferior-octave-mode-hook
          'pretty-mode-on)
