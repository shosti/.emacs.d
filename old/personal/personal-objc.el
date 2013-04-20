(require 'personal-packages)

(add-to-list 'ac-modes 'objc-mode)

(defun set-up-objc-mode ()
  (setq compile-command "cd .. && make -k")
  (setq ac-sources
        '(ac-source-yasnippet
          ac-source-words-in-buffer
          ac-source-abbrev
          ac-source-dictionary
          ac-source-words-in-same-mode-buffers
          ac-source-filename))
  ;; Hack for autocompletion using yasnippet.
  ;; Will use something better once it comes along.
  (let ((auto-snippet-dir (concat prelude-personal-dir "auto-snippets")))
    (unless (member auto-snippet-dir yas/snippet-dirs)
      (message "Loading auto-generated snippets...")
      (add-to-list 'yas/snippet-dirs auto-snippet-dir t)
      (yas/reload-all))))

(add-hook 'objc-mode-hook 'set-up-objc-mode)

(defun objc-header-mode-p ()
  "Determines whether the current buffer is an Objective-C header file"
  (and (string-match "\\.h$" buffer-file-name)
       (equal major-mode 'objc-mode)))
