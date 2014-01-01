(p-require-package 'helm 'melpa)
(p-require-package 'helm-ls-git 'melpa)

(require 'helm-ls-git)

(setq helm-for-files-preferred-list
      '(helm-source-buffers-list
        helm-source-ls-git
        helm-source-recentf
        helm-source-bookmarks
        helm-source-file-cache
        helm-source-files-in-current-dir
        helm-source-locate))

(provide 'p-helm)

;;; p-helm.el ends here
