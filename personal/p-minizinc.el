;;; -*- lexical-binding: t -*-
(p-require-package 'minizinc-mode 'melpa)

(add-to-list 'auto-mode-alist '("\\.mzn\\'" . minizinc-mode))
(add-to-list 'auto-mode-alist '("\\.dzn\\'" . minizinc-mode))

(provide 'p-minizinc)

;;; p-minizinc.el ends here
