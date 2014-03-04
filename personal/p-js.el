;;; -*- lexical-binding: t -*-

(p-require-package 'js2-mode)
;(p-require-package 'simple-httpd 'melpa)
;(p-require-package 'skewer-mode 'melpa)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;(skewer-setup)
(setq-default js2-basic-offset 2)

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;


(defun p-js-comint-filter (output)
  (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                            (replace-regexp-in-string ".*1G.*3G" "> "
                                                      output)))

(defun set-up-inferior-js-mode ()
  (setq comint-process-echoes t)
  (add-to-list 'comint-preoutput-filter-functions
               'p-js-comint-filter))

;(add-hook 'inferior-js-mode-hook 'set-up-inferior-js-mode t)

(provide 'p-js)

;;; p-js.el ends here
