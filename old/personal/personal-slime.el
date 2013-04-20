(require 'personal-packages)

(slime-setup '(slime-repl
               slime-autodoc
               slime-fuzzy
               slime-scratch
               slime-ritz))

(defadvice slime-scratch (after switch-to-clojure-mode)
  "Switch slime scratch buffer to clojure mode"
  (clojure-mode))

(ad-activate 'slime-scratch)

(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

;; Ritz stuff
(require 'projectile)
(defun ritz-server-filter (process output)
  (with-current-buffer (process-buffer process)
    (insert output))
  (when (string-match "Swank server listening on local port \\([0-9]+\\)" output)
    (let ((port (string-to-number (match-string 1 output))))
      (message (format "Starting slime..."))
      (slime-connect "localhost" port))))

(defun ritz-connect ()
  (interactive)
  (message "Starting swank...")
  (let* ((ritz-cmd (format "cd %s && lein ritz" (projectile-project-root)))
         (ritz-process (start-process-shell-command
                        "ritz" "*ritz*" ritz-cmd)))
    (set-process-filter ritz-process 'ritz-server-filter)))

;; Hack to get rid of version check
(defadvice slime-check-version (before version-hack)
  (setq slime-protocol-version 'ignore))

(ad-activate 'slime-check-version)
