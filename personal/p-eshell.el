;;; -*- lexical-binding: t -*-

(require 'eshell)
(require 'em-prompt)
(require 'em-term)
(require 'em-cmpl)
(require 'dirtrack)
(require 'p-path)
(require 'p-leader)
(require 'p-evil)

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
(setenv "GOPATH" (expand-file-name "~/go"))
(setenv "HOMEBREW_GITHUB_API_TOKEN" github-api-token)
(setenv "LANG" "en_US.UTF-8") ; there are some buggy programs out there
(setenv "EDITOR" "ec")

(setq eshell-visual-commands
      (append eshell-visual-commands '("ssh" "tail" "mu" "sl" "htop")))

(defun eshell/cdg ()
  "Change directory to the project's root."
  (eshell/cd (locate-dominating-file default-directory ".git")))

(defun eshell/clear ()
  "Clear the current eshell buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)))

(defun p-eshell-clear-buffer ()
  (interactive)
  (let ((eshell-buffer-maximum-lines 0))
    (eshell-truncate-buffer)))

(evil-define-key 'normal eshell-mode-map
  (kbd "M-k") 'p-eshell-clear-buffer)

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
  (local-set-key (kbd "C-c C-o") 'p-eshell-output-to-buffer)
  (local-set-key (kbd "M-k") 'p-eshell-clear-buffer))

(add-hook 'eshell-mode-hook 'p-set-up-eshell)

(p-set-leader-key
  "Z" 'eshell)

(provide 'p-eshell)

;;; p-eshell.el ends here
