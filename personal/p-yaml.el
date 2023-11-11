(require 'p-programming)

(use-package yaml-ts-mode
  :init
  (add-hook 'yaml-ts-mode-hook #'p-set-up-yaml))

(defun p-set-up-yaml ()
  (p-set-up-prog-mode))

(provide 'p-yaml)

;;; p-yaml.el ends here
