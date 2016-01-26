;;; -*- lexical-binding: t -*-

(p-require-package 'ace-jump-mode)

(with-eval-after-load 'ace-jump-mode
  (ace-jump-mode-enable-mark-sync))

(provide 'p-ace-jump)

;;; p-ace-jump.el ends here
