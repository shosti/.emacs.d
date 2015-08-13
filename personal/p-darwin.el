;;; -*- lexical-binding: t -*-

(when (equal system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none)
  (define-key global-map [ns-drag-file] 'ns-find-file)
  (setq ns-pop-up-frames nil)

  (defvar locate-dirs
    '("~/.emacs.d" "~/src" "~/org" "~/Dropbox/src" "~/go/src"))

  (setq helm-case-fold-search t)
  (setq helm-locate-case-fold-search t)

  (setq helm-locate-command
        (mapconcat 'identity
                   (cons "mdfind %s -name %s"
                         locate-dirs)
                   " -onlyin "))

  ;; HACK: eventually incorporate this into wacspace.el
  (defvar p-last-screen-conf nil)

  (defun p-screens ()
    (let ((screens
           (with-temp-buffer
             (shell-command
              "system_profiler SPDisplaysDataType | grep Resolution"
              (current-buffer))
             (->> (s-match-strings-all
                   "Resolution: \\([0-9]+\\) x \\([0-9]+\\)"
                   (buffer-string))
               (--map (cons
                       (string-to-number (nth 1 it))
                       (string-to-number (nth 2 it))))))))

      (setq p-last-screen-conf screens)

      screens))

  (defadvice wacspace-restore (around check-for-screen-change activate)
    (let ((screens p-last-screen-conf))
      (if (equal screens (p-screens))
          ad-do-it
        nil))))

(provide 'p-darwin)

;;; p-darwin.el ends here
