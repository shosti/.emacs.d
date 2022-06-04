;;; -*- lexical-binding: t -*-

(p-require-package 'swift-mode)
(p-require-package 'flycheck-swift)

(defun p-swift-format-buffer ()
  "Rewrite current buffer in a canonical format using swift-format."
  (interactive)
  (when (executable-find "swift-format")
    (let* ((config-arg
            (when-let ((dir (locate-dominating-file buffer-file-name ".swift-format")))
              (list "--configuration" (concat (expand-file-name dir) ".swift-format"))))
           (buf (get-buffer-create "*swift-format*"))
           (args `(,(point-min) ,(point-max) "swift-format" nil ,buf nil "format" ,@config-arg)))
      (if (zerop (apply #'call-process-region args))
          (let ((point (point))
                (window-start (window-start)))
            (erase-buffer)
            (insert-buffer-substring buf)
            (goto-char point)
            (set-window-start nil window-start))
        (message "swift-format: %s" (with-current-buffer buf (buffer-string))))
      (kill-buffer buf))))

(defun p-set-up-swift ()
  (when (eq system-type 'darwin)
    (setq company-backends '(company-capf))
    (add-hook 'before-save-hook #'p-swift-format-buffer)))

(add-hook 'swift-mode-hook #'p-set-up-swift)

(provide 'p-swift)

;;; p-swift.el ends here
