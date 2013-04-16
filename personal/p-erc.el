;;; -*- lexical-binding: t -*-

(p-require-package 'bitlbee)

(require 'p-options)

;; Join the a couple of interesting channels whenever connecting to Freenode.
(eval-after-load 'erc
  '(progn

     (setq erc-autojoin-channels-alist '(("freenode.net"
                                          "#emacs" "#clojure"
                                          "#haskell")
                                         ("mitx-irc.i4x.org" "#6002")))

     (setq erc-track-enable-keybindings nil)

     ;; set your nickname
     (setq erc-nick "shosti")

     ;; auto identify
     (when (p-password 'erc-pass)
       (require 'erc-services)
       (erc-services-mode 1)
       (setq erc-prompt-for-nickserv-password nil)
       (setq erc-nickserv-passwords
             `((freenode ((,erc-nick . ,erc-pass))))))))

(defun p-erc-connect ()
  (interactive)
  (erc :server "irc.freenode.net")
  (erc :server "irc.mitx.mit.edu"))

;;bitlbee configuration
(autoload 'bitlbee-start "bitlbee" nil t)
(defun gtalk ()
  (interactive)
  (bitlbee-start)
  (erc :server "localhost" :password erc-pass))

(provide 'p-erc)
