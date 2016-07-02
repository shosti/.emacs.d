;;; -*- lexical-binding: t -*-

(p-require-package 'js2-mode)



;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(setq js2-mode-show-strict-warnings nil)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq js-indent-level 2)

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

(defun p-set-up-js2-mode ()
  (flycheck-mode 1))

(with-eval-after-load 'js2-mode
  (add-hook 'js2-mode-hook #'p-set-up-js2-mode))

(provide 'p-js)

;;; p-js.el ends here
