;;; -*- lexical-binding: t -*-

(p-require-package 'bazel 'melpa)

;; Stolen from https://github.com/brown/bazel-mode/blob/master/bazel-mode.el
(defun p-starlark-file-type (file-name)
  (let* ((dot (cl-position ?. file-name :from-end t))
         (base (if dot (subseq file-name 0 dot) file-name))
         (extension (if dot (subseq file-name (1+ dot)) "")))
    (cond ((or (string= base "BUILD") (string= extension "BUILD")) "build")
          ((or (string= base "WORKSPACE") (string= extension "WORKSPACE")) "workspace")
          (t "bzl"))))

(defun p-bazel-parse-diff-action ()
  (unless (looking-at (rx line-start
                          (group (+ digit)) (? ?, (group (+ digit)))
                          (group (| ?a ?d ?c))
                          (group (+ digit)) (? ?, (group (+ digit)))
                          line-end))
    (error "bad buildifier diff output"))
  (let* ((orig-start (string-to-number (match-string 1)))
         (orig-count (if (null (match-string 2))
                         1
                       (1+ (- (string-to-number (match-string 2)) orig-start))))
         (command (match-string 3))
         (formatted-count (if (null (match-string 5))
                              1
                            (1+ (- (string-to-number (match-string 5))
                                   (string-to-number (match-string 4)))))))
    (list command orig-start orig-count formatted-count)))

(defun p-bazel-patch-buffer (buffer diff-buffer)
  "Applies the diff editing actions contained in DIFF-BUFFER to BUFFER."
  (with-current-buffer buffer
    (save-restriction
      (widen)
      (goto-char (point-min))
      (let ((orig-offset 0)
            (current-line 1))
        (cl-flet ((goto-orig-line (orig-line)
                    (let ((desired-line (+ orig-line orig-offset)))
                      (forward-line (- desired-line current-line))
                      (setq current-line desired-line)))
                  (insert-lines (lines)
                    (dolist (line lines) (insert line))
                    (cl-incf current-line (length lines))
                    (cl-incf orig-offset (length lines)))
                  (delete-lines (count)
                    (let ((start (point)))
                      (forward-line count)
                      (delete-region start (point)))
                    (cl-decf orig-offset count)))
          (save-excursion
            (with-current-buffer diff-buffer
              (goto-char (point-min))
              (while (not (eobp))
                (cl-multiple-value-bind (command orig-start orig-count formatted-count)
                    (p-bazel-parse-diff-action)
                  (forward-line)
                  (cl-flet ((fetch-lines ()
                            (cl-loop repeat formatted-count
                                     collect (let ((start (point)))
                                               (forward-line 1)
                                               ;; Return only the text after "< " or "> ".
                                               (substring (buffer-substring start (point)) 2)))))
                    (cond ((equal command "a")
                           (let ((lines (fetch-lines)))
                             (with-current-buffer buffer
                               (goto-orig-line (1+ orig-start))
                               (insert-lines lines))))
                          ((equal command "d")
                           (forward-line orig-count)
                           (with-current-buffer buffer
                             (goto-orig-line orig-start)
                             (delete-lines orig-count)))
                          ((equal command "c")
                           (forward-line (+ orig-count 1))
                           (let ((lines (fetch-lines)))
                             (with-current-buffer buffer
                               (goto-orig-line orig-start)
                               (delete-lines orig-count)
                               (insert-lines lines)))))))))))))))

(defun p-bazel-format ()
  "Format the current buffer using buildifier."
  (interactive)
  (let ((input-file nil)
        (output-buffer nil)
        (errors-file nil)
        (file-name (file-name-nondirectory (buffer-file-name))))
    (unwind-protect
        (progn
          (setf input-file (make-temp-file "bazel-format-input-")
                output-buffer (get-buffer-create "*bazel-format-output*")
                errors-file (make-temp-file "bazel-format-errors-"))
          (write-region nil nil input-file nil 'silent-write)
          (with-current-buffer output-buffer (erase-buffer))
          (let ((status
                 (call-process "buildifier" nil `(,output-buffer ,errors-file) nil
                               (concat "--diff_command=" "diff")
                               "--mode=diff"
                               (concat "--type=" (p-starlark-file-type file-name))
                               input-file)))
            (cl-case status
              ;; No reformatting needed or reformatting was successful.
              ((0 4)
               (save-excursion (p-bazel-patch-buffer (current-buffer) output-buffer))
               ;; Delete any previously created errors buffer.
               (let ((errors-buffer (get-buffer "*BazelFormatErrors*")))
                 (when errors-buffer (kill-buffer errors-buffer))))
              (t
               (cl-case status
                 (1 (message "Starlark language syntax errors"))
                 (2 (message "buildifier invoked incorrectly or cannot run diff"))
                 (3 (message "buildifier encountered an unexpected run-time error"))
                 (t (message "unknown buildifier error")))
               (sit-for 1)
               (let ((errors-buffer (get-buffer-create "*BazelFormatErrors*")))
                 (with-current-buffer errors-buffer
                   ;; A previously created errors buffer is read only.
                   (setq buffer-read-only nil)
                   (erase-buffer)
                   (let ((coding-system-for-read "utf-8"))
                     (insert-file-contents-literally errors-file))
                   (when (= status 1)
                     ;; Replace the name of the temporary input file with that
                     ;; of the name of the file we are saving in all syntax
                     ;; error messages.
                     (let ((regexp (rx-to-string `(sequence line-start (group ,input-file) ":"))))
                       (while (search-forward-regexp regexp nil t)
                         (replace-match file-name t t nil 1)))
                     ;; Use compilation mode so next-error can be used to find
                     ;; the errors.
                     (goto-char (point-min))
                     (compilation-mode)))
                 (display-buffer errors-buffer))))))
      (when input-file (delete-file input-file))
      (when output-buffer (kill-buffer output-buffer))
      (when errors-file (delete-file errors-file)))))

(defun p-set-up-bazel-mode ()
  (add-hook 'before-save-hook #'p-bazel-format nil t))

(with-eval-after-load 'bazel-mode
  (add-hook 'bazel-mode-hook #'p-set-up-bazel-mode))

(provide 'p-bazel)

;;; p-bazel.el ends here
