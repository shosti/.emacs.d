;;; -*- lexical-binding: t -*-

(require 'p-options)
(require 'p-jabber)

(defvar p-erc-channels '("#emacsconf"))

(p-load-private "erc-settings.el")

(setq erc-track-enable-keybindings nil
      erc-hide-list '("JOIN" "PART" "QUIT" "MODE" "324" "329" "332" "333" "353" )
      erc-track-exclude-server-buffer t
      erc-log-channels-directory (expand-file-name "~/.erc/logs")
      erc-save-queries-on-quit t
      erc-join-buffer 'bury
      erc-autojoin-channels-alist (list
                                   (cons "freenode.net"
                                         p-erc-channels)))

;; Join the a couple of interesting channels whenever connecting to Freenode.
(with-eval-after-load 'erc
  (add-to-list 'erc-modules 'smiley)
  (setq erc-password (password-store-get "Personal/erc"))

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

(defun p-erc-newline-hack ()
  "For some reason, evil mode keeps adding spurious
newlines. This should fix it."
  (save-excursion
    (forward-line)
    (when (and (bolp) (eolp))
      (backward-delete-char 1))))

(advice-add #'erc-send-current-line :before #'p-erc-newline-hack)

(defun p-set-up-erc ()
  (p-company-emoji-init)
  (seq-each (lambda (num)
              (evil-local-set-key
               'normal num
               (lambda () (interactive) (user-error "No fat-fingering!"))))
            (seq-map #'number-to-string '(1 2 3 4 5 6 7 8 9))))

(add-hook 'erc-mode-hook #'p-set-up-erc)

(provide 'p-erc)

;;; p-erc.el ends here
