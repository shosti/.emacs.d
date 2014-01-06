;;; -*- lexical-binding: t -*-

(p-require-package 'helm 'melpa)
(p-require-package 'helm-ls-git 'melpa)

(require 'p-leader)

(eval-after-load 'helm
  '(progn
     (require 'helm-ls-git)
     (define-key helm-map (kbd "C-w") nil)
     (setq helm-for-files-preferred-list
           '(helm-source-buffers-list
             helm-source-ls-git
             helm-source-recentf
             helm-source-bookmarks
             helm-source-file-cache
             helm-source-files-in-current-dir
             helm-source-locate))))

(p-set-leader-key "b" 'helm-for-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(provide 'p-helm)

;;; p-helm.el ends here
