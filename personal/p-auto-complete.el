;;; -*- lexical-binding: t -*-

(p-require-package 'popup 'melpa)
(p-require-package 'auto-complete 'melpa)

(require 'auto-complete-config)

(ac-config-default)

(setq ac-use-fuzzy t)
(setq ac-use-menu-map t)
(ac-flyspell-workaround)

(provide 'p-auto-complete)

;;; p-auto-complete.el ends here
