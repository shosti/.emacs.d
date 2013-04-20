(eval-when-compile
  (require 'cl))

(defun describe-last-function ()
  "Describes the last executed command"
  (interactive)
  (describe-function last-command))

(defun add-hooks (hooks function)
  (mapc '(lambda (hook)
           (add-hook hook function))
        hooks))

(defun my-backward-kill-word (arg)
  "If the region is active, kills region.  Otherwise, backwards kills word."
  (interactive "p")
  (if transient-mark-mode
      (if (use-region-p)
          (kill-region (region-beginning) (region-end))
        (subword-backward-kill arg)) ;;HACK, but I always use subword mode
    (kill-region (region-beginning) (region-end))))

(defun my-paredit-backward-kill-word ()
  "Paredit replacement for backward-kill-word."
  (interactive)
  (if (use-region-p)
      (paredit-kill-region (region-beginning) (region-end))
    (paredit-backward-kill-word)))

(defun my-move-line-down (arg)
  "Move current line down while staying on current line"
  (interactive "p")
  (beginning-of-line)
  (newline arg)
  (indent-for-tab-command)
  (previous-line arg)
  (indent-for-tab-command))

(defun bh-choose-header-mode ()
  (interactive)
  (cond ((string-equal (substring (buffer-file-name) -2) ".h")
         (progn
           ;; OK, we got a .h file, if a .m file exists we'll assume it's
           (let ((dot-m-file (concat (substring (buffer-file-name) 0 -1) "m")))
             (if (file-exists-p dot-m-file)
                 (progn
                   (objc-mode))
               (if (file-exists-p dot-cpp-file)
                   (c++-mode))))))
        ((string-equal (substring (buffer-file-name) -2) ".m")
         ;; Check to see if header file; if not, assume octave mode
         (let ((dot-h-file (concat (substring (buffer-file-name) 0 -1) "h")))
           (if (file-exists-p dot-h-file)
               (progn
                 (objc-mode))
             (octave-mode))))))

(defun read-lines (fpath)
  "Return a list of lines of a file at at FPATH."
  (with-temp-buffer
    (insert-file-contents fpath)
    (split-string (buffer-string) "\n" t)))

(defun path-from-file (fpath)
  "Reads a :-delineated path file and adds
it to exec-path and the PATH variable"
  (with-temp-buffer
    (insert-file-contents fpath)
    (setq exec-path (append (mapcar 'chomp (split-string (buffer-string) ":" t))
                            exec-path))
    (setenv "PATH" (mapconcat 'identity exec-path ":"))))

(defun chomp (str)
  "..."
  (let ((s (if (symbolp str)(symbol-name str) str)))
    (save-excursion
      (while (and
              (not (null (string-match "^\\( \\|\f\\|\t\\|\n\\)" s)))
              (> (length s) (string-match "^\\( \\|\f\\|\t\\|\n\\)" s)))
        (setq s (replace-match "" t nil s)))
      (while (and
              (not (null (string-match "\\( \\|\f\\|\t\\|\n\\)$" s)))
              (> (length s) (string-match "\\( \\|\f\\|\t\\|\n\\)$" s)))
        (setq s (replace-match "" t nil s))))
    s))

(defun lorem ()
  (interactive)
  (insert
   "Lorem ipsum dolor sit amet, consectetur adipisicing
  elit, sed do eiusmod tempor incididunt ut labore et dolore
  magna aliqua. Ut enim ad minim veniam, quis nostrud
  exercitation ullamco laboris nisi ut aliquip ex ea commodo
  consequat. Duis aute irure dolor in reprehenderit in voluptate
  velit esse cillum dolore eu fugiat nulla pariatur. Excepteur
  sint occaecat cupidatat non proident, sunt in culpa qui officia
  deserunt mollit anim id est laborum."))

(require 'projectile)
(defun current-project-name ()
  (car (last
        (split-string (projectile-project-root) "/") 2)))

(provide 'personal-functions)
