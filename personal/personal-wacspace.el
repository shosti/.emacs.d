(personal-require-package 'wacspace 'melpa)

(require 'wacspace)
(require 'personal-bindings)
(require 'personal-display)
(require 'scala-mode2)
(require 'ensime)

(wacs-set-frame-fn full display-fill-screen)
(wacs-set-frame-fn right display-right-half)
(wacs-set-frame-fn left display-left-half)

(defwacspace (scala-mode)
  (:before (lambda ()
             (ensime-sbt-switch)
             (ensime-inf-switch)))
  (:default
   (:winconf 3winv)
   (:frame full)
   (:aux1 (:buffer "*ensime-inferior-scala*"))
   (:aux2 (:cmd (lambda ()
                  (switch-to-buffer
                   (--first
                    (string-match-p "*ensime-sbt*"
                                    (buffer-name it))
                    (buffer-list)))))))
  (:1
   (:winconf 2winh)
   (:frame right)))

(define-key ctl-z-map (kbd "w") 'wacspace)
(define-key ctl-z-map (kbd "C-w") 'wacspace)
(define-key ctl-z-map (kbd "s") 'wacspace-save)
(define-key ctl-z-map (kbd "C-s") 'wacspace-save)

(provide 'personal-wacspace)
