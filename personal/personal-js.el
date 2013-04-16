;;; -*- lexical-binding: t -*-

(personal-require-package 'starter-kit-js)
(personal-require-package 'js-comint)

(setq inferior-js-program-command "/usr/local/bin/node")

(defun personal-js-comint-filter (output)
  (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                            (replace-regexp-in-string ".*1G.*3G" "> "
                                                      output)))

(defun set-up-inferior-js-mode ()
  (setq comint-process-echoes t)
  (add-to-list 'comint-preoutput-filter-functions
               'personal-js-comint-filter))

(add-hook 'inferior-js-mode-hook 'set-up-inferior-js-mode t)

(provide 'personal-js)
