(defun set-up-cc-cedet ()
  (add-to-list 'ac-sources 'ac-source-semantic)
  (semantic-mode 1)
  (semantic-clang-activate))

(add-hook 'c-mode-hook 'set-up-cc-cedet)
