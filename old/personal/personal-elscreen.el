(require 'personal-packages)

(elscreen-start)

;;eshell
(global-set-key "\C-z\C-z" 'eshell)

;;display
(global-set-key (kbd "C-z C-1") 'display-fill-screen)
(global-set-key (kbd "C-z C-2") 'display-left-half)
(global-set-key (kbd "C-z C-3") 'display-right-half)
(elscreen-toggle-display-tab)
