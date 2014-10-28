;;; -*- lexical-binding: t -*-
(p-require-package 'flx)
(p-require-package 'flx-ido)
(p-require-package 'smex)
(p-require-package 'ido-ubiquitous)

(require 'p-leader)
(require 'smex)

(ido-mode 1)
(ido-ubiquitous-mode 1)
(flx-ido-mode 1)

;;;;;;;;;;
;; smex ;;
;;;;;;;;;;

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;;;;;;;;;
;; ido ;;
;;;;;;;;;

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      ido-max-prospects 10)

(defun p-ido-setup-keybindings ()
  (define-key ido-file-completion-map (kbd "~")
    (lambda ()
      (interactive)
      (if (looking-back "/")
          (insert "~/")
        (call-interactively 'self-insert-command))))
  (define-key ido-file-completion-map (kbd "C-w")
    'ido-delete-backward-word-updir)
  (define-key ido-common-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-common-completion-map (kbd "C-p") 'ido-prev-match))

(add-hook 'ido-setup-hook
          'p-ido-setup-keybindings)

(p-set-leader-key
  "k" 'ido-kill-buffer
  "f" 'ido-find-file
  "B" 'ido-switch-buffer)

(provide 'p-ido)

;;; p-ido.el ends here
