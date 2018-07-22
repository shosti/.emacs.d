;;; -*- lexical-binding: t -*-
(p-require-package 'yaml-mode 'melpa)

(defun p-yaml-hook ()
  (auto-fill-mode 0))

(with-eval-after-load 'yaml-mode
  (add-hook 'yaml-mode-hook #'p-yaml-hook))

(provide 'p-yaml)

;;; p-yaml.el ends here
