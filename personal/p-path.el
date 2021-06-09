;;; -*- lexical-binding: t -*-

(unless (eq system-type 'windows-nt)
  (defvar path-extra
    '("~/bin"
      "~/go/bin"
      "~/.cargo/bin"
      "~/.asdf/bin"
      "~/.asdf/shims"
      "~/.poetry/bin"))

  (when (eq system-type 'darwin)
    (add-to-list 'path-extra "/opt/homebrew/bin" t))

  (setq exec-path
        (append (mapcar #'expand-file-name path-extra)
                exec-path))
  (setenv "PATH" (mapconcat 'identity exec-path ":")))

(provide 'p-path)
