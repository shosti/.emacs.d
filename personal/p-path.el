;;; -*- lexical-binding: t -*-

(unless (eq system-type 'windows-nt)
  (defvar path-extra
    '("~/.cargo/bin"
      "~/.asdf/bin"
      "~/.asdf/shims"
      "~/.poetry/bin"))

  (setq exec-path
        (append (mapcar #'expand-file-name path-extra)
                exec-path))
  (setenv "PATH" (mapconcat 'identity exec-path ":")))

(provide 'p-path)
