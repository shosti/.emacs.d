;;; -*- lexical-binding: t -*-

(defvar markdown-extensions
  '("markdown"
    "mdown"
    "mkdn"
    "md"
    "mdwn"
    "mdtxt"
    "mdtext"
    "text"))

(cl-dolist (ext markdown-extensions)
  (add-to-list 'auto-mode-alist
               (cons (concat "\\." ext "$")
                     'markdown-mode)))

(provide 'personal-markdown)
