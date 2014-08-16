;;; -*- lexical-binding: t -*-

(p-require-package 'markdown-mode)

(defvar markdown-extensions
  '("markdown"
    "mdown"
    "mkdn"
    "md"
    "mdwn"
    "mdtxt"
    "mdtext"
    "text"))

(--each markdown-extensions
  (add-to-list 'auto-mode-alist
               (cons (concat "\\." it "$")
                     'markdown-mode)))

(provide 'p-markdown)
