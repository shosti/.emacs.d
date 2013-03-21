(personal-require-package 'expand-region 'melpa)

(require 'expand-region)

(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'personal-expand-region)
