;;; -*- lexical-binding: t -*-

(let ((ensime-lib (concat user-emacs-directory "opt/ensime/elisp")))
  (when (file-exists-p ensime-lib)
    (add-to-list 'load-path ensime-lib)
    (eval-after-load 'scala-mode2
      '(progn
         (require 'ensime)
         (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))))

(provide 'personal-scala)
