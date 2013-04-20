(require 'personal-packages)
(require 'personal-eshell)

(setq custom-theme-directory (concat prelude-personal-dir "/themes/"))
(load-theme 'tomorrow-night)

(let ((password-file (expand-file-name "~/.passwords.gpg")))
  (when (file-exists-p password-file)
    (load password-file)))

(server-start)

(provide 'personal-init)
