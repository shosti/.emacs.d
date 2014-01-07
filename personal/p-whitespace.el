;;; -*- lexical-binding: t -*-

(setq whitespace-style '(face trailing lines-tail tabs)
      whitespace-line-column 80)

(defun p-turn-on-whitespace ()
  (whitespace-mode 1))

(add-hook 'prog-mode-hook 'p-turn-on-whitespace)

(provide 'p-whitespace)

;;; p-whitespace.el ends here
