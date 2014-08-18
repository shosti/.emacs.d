;;; A minimal configuration for debugging packages
;;
;; NOT TO BE LOADED IN THE ACTUAL EMACS CONFIG!!!

(require 'package)
(customize-set-variable
 'package-archives
 (append package-archives
         '(("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
           ("marmalade" . "http://marmalade-repo.org/packages/"))))
(customize-set-variable 'show-paren-mode t)
(customize-save-customized)
(package-refresh-contents)
