(require 'personal-packages)
(require 'personal-init)

;; Join the a couple of interesting channels whenever connecting to Freenode.
(setq erc-autojoin-channels-alist '(("freenode.net"
                                     "#emacs" "#clojure"
                                     "#haskell")
                                    ("mitx-irc.i4x.org" "#6002")))

(setq erc-track-enable-keybindings nil)

;; set your nickname
(setq erc-nick "shosti")

;; auto identify
(when (boundp 'erc-pass)
  (require 'erc-services)
  (erc-services-mode 1)
  (setq erc-prompt-for-nickserv-password nil)
  (setq erc-nickserv-passwords
        `((freenode ((,erc-nick . ,erc-pass))))))
(defun my-erc-connect ()
  (interactive)
  (erc :server "irc.freenode.net")
  (erc :server "irc.mitx.mit.edu"))

;;bitlbee configuration
(autoload 'bitlbee-start "bitlbee" nil t)
(defun gtalk ()
  (interactive)
  (bitlbee-start)
  (erc :server "localhost" :password erc-pass))

(require 'elscreen)
(global-set-key "\C-ze"
                '(lambda ()
                   (interactive)
                   (elscreen-create)
                   (my-erc-connect)
                   (gtalk)))
