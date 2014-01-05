;;; -*- lexical-binding: t -*-

(require 'p-options)

;;;;;;;;;;;;;;
;; Settings ;;
;;;;;;;;;;;;;;

(eval-after-load 'gnus
  '(progn
     (p-load-private "gnus-settings.el")))


(provide 'p-gnus)

;;; p-gnus.el ends here
