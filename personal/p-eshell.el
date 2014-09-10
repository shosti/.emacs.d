;;; -*- lexical-binding: t -*-

(p-require-package 'dirtrack)

(require 'eshell)
(require 'em-prompt)
(require 'em-term)
(require 'em-cmpl)
(require 'dirtrack)
(require 'p-path)
(require 'p-leader)

(defvar github-api-token)
(p-load-private "eshell-settings.el")

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(setq eshell-scroll-to-bottom-on-input t
      eshell-cmpl-cycle-completions t
      eshell-scroll-show-maximum-output nil
      eshell-directory-name (concat p-private-dir "eshell/")
      eshell-buffer-shorthand t
      eshell-save-history-on-exit t
      eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'")

(setenv "TERM" "dumb")
(setenv "EDITOR" "emacsclient")
(setenv "PAGER" "cat")
(setenv "NODE_PATH" "/usr/local/lib/node")
(setenv "PYTHONPATH"
        "/usr/local/lib/python2.7/site-packages")
(setenv "HOMEBREW_GITHUB_API_TOKEN" github-api-token)

(setq eshell-visual-commands
      (append eshell-visual-commands '("ssh" "tail" "mu" "sl")))

(defun eshell/cdg ()
  "Change directory to the project's root."
  (eshell/cd (locate-dominating-file default-directory ".git")))

(defun eshell/clear ()
  "Clear the current eshell buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)))

(defun p-eshell-output-to-buffer ()
  "Dump the output of the last command to a temporary buffer."
  (interactive)
  (let ((text (buffer-substring-no-properties
               (eshell-beginning-of-output)
               (eshell-end-of-output))))
    (switch-to-buffer-other-window "*<eshell-out>*")
    (goto-char (point-max))
    (insert text)))

;;;;;;;;;;;
;; Hooks ;;
;;;;;;;;;;;

(defun p-set-up-eshell ()
  (setq eshell-path-env (getenv "PATH"))
  ;;hack--not sure why it doesn't actually work
  (visual-line-mode 0)
  (dirtrack-mode 1)
  ;; keybindings with eshell are weird
  (local-set-key (kbd "C-c C-o") 'p-eshell-output-to-buffer))

(add-hook 'eshell-mode-hook 'p-set-up-eshell)

(p-set-leader-key
  "z" 'eshell
  "Z" 'shell)

(provide 'p-eshell)

;;; p-eshell.el ends here
