;;; -*- lexical-binding: t -*-

(p-require-package 'twittering-mode)

(with-eval-after-load 'twittering-mode
  (setq twittering-use-master-password t
        twittering-icon-mode t
        twittering-use-icon-storage t))

(provide 'p-twitter)

;;; p-twitter.el ends here
