;;; -*- lexical-binding: t -*-
;; Some basic macros

(defmacro p-configure-feature (feature &rest body)
  "Configure FEATURE with BODY after FEATURE is loaded."
  (declare (indent 1))
  (let ((fn-name (intern (concat "p-config-" (symbol-name feature)))))
    `(progn
       (defun ,fn-name ()
         ,@body)
       (eval-after-load ',feature '(,fn-name)))))

(provide 'p-macros)

;;; p-macros.el ends here
