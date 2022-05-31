;;; -*- lexical-binding: t -*-

(p-require-package 'eldoc 'gnu)

(setq eldoc-echo-area-use-multiline-p 5)

;; Annoying hack to get motion states working (since eldoc buffer uses fundamental mode)
(defun p-eldoc-doc-buffer-setup (&optional interactive)
  (with-current-buffer eldoc--doc-buffer
    (evil-mode 1)
    (evil-motion-state 1)))

(with-eval-after-load 'eldoc
  (advice-add #'eldoc-doc-buffer :after #'p-eldoc-doc-buffer-setup))

(provide 'p-eldoc)

;;; p-eldoc.el ends here
