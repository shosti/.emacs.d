;;; -*- lexical-binding: t -*-

(require 'p-options)
(require 'p-jabber)

(defvar p-erc-channels '("#emacs"
                         "#clojure"
                         "#haskell"
                         "#ruby"
                         "#vim"
                         "##security"))

(p-load-private "erc-settings.el")

;; Join the a couple of interesting channels whenever connecting to Freenode.
(p-configure-feature erc
  (add-to-list 'erc-modules 'smiley)
  (setq erc-autojoin-channels-alist
        (list
         (cons "freenode.net"
               p-erc-channels)))

  (setq erc-track-enable-keybindings nil
        erc-nick "shosti"
        erc-hide-list '("JOIN" "PART" "QUIT" "MODE")
        erc-password (p-password "Personal/erc"))

  ;; auto identify
  (erc-services-mode 1)
  (setq erc-prompt-for-nickserv-password nil)
  (setq erc-nickserv-passwords
        `((freenode ((,erc-nick . ,erc-password))))))

(defun p-erc-connect ()
  (interactive)
  (erc :server "irc.freenode.net"))

(defun p-erc-rooms ()
  "Return a list of erc buffers."
  (-filter (lambda (buffer)
             (with-current-buffer buffer
               (eq major-mode 'erc-mode)))
           (buffer-list)))

;; This seems like as good a place as any to put this
(defun p-switch-to-room ()
  (interactive)
  (let* ((chatrooms (mapcar (lambda (room)
                              (cons (buffer-name room) room))
                            (p-erc-rooms)))
         (room-names (-map 'car chatrooms))
         (room
          (completing-read "Room: " room-names nil nil nil nil
                           (car room-names))))
    (switch-to-buffer (cdr (assoc room chatrooms)))))

(p-set-leader-key "j" 'p-switch-to-room)

(provide 'p-erc)
