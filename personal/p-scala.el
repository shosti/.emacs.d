;;; -*- lexical-binding: t -*-

(p-require-package 'scala-mode2 'melpa)

(defun load-ensime ()
  (let ((ensime-lib (concat user-emacs-directory "opt/ensime/elisp")))
    (when (file-exists-p ensime-lib)
      (add-to-list 'load-path ensime-lib)
      (require 'ensime)
      (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

      ;; Hack to fix ensime comint prompt
      (defadvice ensime-sbt (after set-process-echoes activate)
        (setq comint-process-echoes t)))))

(eval-after-load 'scala-mode2
  '(progn
     (load-ensime)
     (define-key scala-mode-map (kbd "RET") 'newline-and-indent)
     (define-key scala-mode-map (kbd "C-c C-c") 'ensime-inf-eval-buffer)))

(provide 'p-scala)
