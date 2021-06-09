;;; -*- lexical-binding: t -*-

(when (eq system-type 'darwin)
  (when (executable-find "gpgconf")
    (setenv "SSH_AUTH_SOCK"
            (string-trim
             (shell-command-to-string
              "gpgconf --list-dirs agent-ssh-socket")))))

(provide 'p-mac)

;;; p-mac.el ends here
