(require 'personal-packages)

(require 'auto-complete-config)

(ac-config-default)

(setq ac-use-fuzzy t)
(setq ac-use-menu-map t)
(ac-flyspell-workaround)

(defun set-up-auto-complete-mode ()
  ;;  (setq ac-sources (remove 'ac-source-yasnippet ac-sources))
  )

(mapc (lambda (hook)
        (add-hook hook 'set-up-auto-complete-mode t))
      '(emacs-lisp-mode-hook
        c-mode-common-hook
        ruby-mode-hook
        css-mode-hook))
