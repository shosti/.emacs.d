(require 'seq)
(require 'p-leader)

(unless (package-installed-p 'claude-code)
  (package-vc-install '(claude-code :url "https://github.com/stevemolitor/claude-code.el")))

(require 'claude-code)
(setq claude-code-prefix-key "C-c c")
(define-key global-map (kbd "C-c c") claude-code-command-map)
(claude-code-mode)

(defvar p-promptdir (expand-file-name "~/prompts"))

(defun p-find-prompt ()
  (interactive)
  (let ((ido-use-filename-at-point nil))
    (ido-find-file-in-dir p-promptdir)))

(p-set-leader-key "p" #'p-find-prompt)

(defun p-create-prompt ()
  (interactive)
  (let* ((slug (read-string "Enter prompt slug: "))
         (files (directory-files p-promptdir))
         (prompts (seq-filter (lambda (f) (string-match-p "^[0-9]+.*\\.md$" f)) files))
         (numbers (seq-map (lambda (f)
                             (string-match "^\\([0-9]+\\)-" f)
                             (string-to-number (match-string 1 f)))
                           prompts))
         (next-num (+ 1 (seq-max numbers)))
         (fname (expand-file-name (concat p-promptdir "/" (format "%03d-%s.md" next-num slug)))))
    (find-file (concat p-promptdir) fname)))

(p-set-leader-key "P" #'p-create-prompt)



(provide 'p-claude-code)

;;; p-claude-code.el ends here
