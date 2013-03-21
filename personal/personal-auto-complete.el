(personal-require-package 'popup 'melpa)
(personal-require-package 'auto-complete 'melpa)

(require 'auto-complete-config)

(ac-config-default)

(setq ac-use-fuzzy t)
(setq ac-use-menu-map t)
(ac-flyspell-workaround)

(provide 'personal-auto-complete)
