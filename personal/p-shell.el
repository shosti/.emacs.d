;;; -*- lexical-binding: t -*-

(require 'p-bindings)

(with-eval-after-load 'shell
  (add-to-list 'explicit-bash-args "--login"))

(global-set-key (kbd "C-z C-t") 'ansi-term)

(provide 'p-shell)
