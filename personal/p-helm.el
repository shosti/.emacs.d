(p-require-package 'helm 'melpa)
(p-require-package 'helm-ls-git 'melpa)

(require 'helm-ls-git)
(require 'p-leader)

(setq helm-for-files-preferred-list
      '(helm-source-buffers-list
        helm-source-ls-git
        helm-source-recentf
        helm-source-bookmarks
        helm-source-file-cache
        helm-source-files-in-current-dir
        helm-source-locate))

(p-set-leader-key "b" 'helm-for-files)

(provide 'p-helm)

;;; p-helm.el ends here
