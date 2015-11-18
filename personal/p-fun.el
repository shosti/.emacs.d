(p-require-package 'howdoi 'melpa)

(require 'spotify-autoload)
(require 'p-leader)

(p-set-leader-key "P" #'spotify-playpause)

(provide 'p-fun)

;;; p-fun.el ends here
