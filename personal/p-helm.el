;;; -*- lexical-binding: t -*-

(p-require-package 'helm 'melpa)

(require 'p-leader)

(with-eval-after-load 'helm
  (define-key helm-map (kbd "C-w") nil)
  (setq helm-for-files-preferred-list
        '(helm-source-buffers-list
          helm-source-recentf
          helm-source-bookmarks
          helm-source-file-cache
          helm-source-files-in-current-dir
          helm-source-locate)
        helm-buffers-fuzzy-matching t))

(p-set-leader-key
  "b" 'helm-for-files
  "8" 'helm-unicode)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(provide 'p-helm)

;;; p-helm.el ends here
