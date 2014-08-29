;;; -*- lexical-binding: t -*-

(require 'p-org)
(require 'p-leader)

(p-require-package 'calfw)

(autoload 'cfw:open-org-calendar "calfw-org" nil t)

(p-set-leader-key
  "oc" 'cfw:open-org-calendar)

(provide 'p-cal)

;;; p-cal.el ends here
