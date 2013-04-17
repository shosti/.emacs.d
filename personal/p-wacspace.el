(add-to-list 'load-path (expand-file-name "~/src/wacspace"))

(require 'wacspace)
(require 'p-bindings)
(require 'p-display)
(require 'scala-mode2)
(require 'ensime)
(require 'findr)

(wacs-set-frame-fn full display-fill-screen)
(wacs-set-frame-fn right display-right-half)
(wacs-set-frame-fn left display-left-half)

(defun p-scala-test-file ()
  (find-file (car (findr "Suite.scala$"
                         (concat (wacs-project-dir)
                                 "src/test/scala")))))

(defwacspace (scala-mode)
  (:before (lambda ()
             (ensime-sbt-switch)
             (ensime-inf-switch)))
  (:base-file ".ensime")
  (:default
   (:winconf 3winv)
   (:frame full)
   (:aux1 (:cmd p-scala-test-file))
   (:aux2 (:buffer "*ensime-sbt*")))
  (:1
   (:aux1 (:buffer "*ensime-inferior-scala*")))
  (:2
   (:winconf 2winh)
   (:frame right)
   (:aux2 (:buffer "*ensime-sbt*"))))

(defwacspace (ruby-mode rinari-minor-mode)
  (:before (lambda ()
             (p-rinari-guard)
             (rinari-console)))
  (:default
   (:winconf 3winv)
   (:frame full)
   (:aux1 (:cmd wacs-eshell))
   (:aux2 (:buffer "*guard*")))
  (:1
   (:aux1 (:buffer "*rails console*")))
  (:2
   (:winconf 2winh)
   (:frame right)))

(defwacspace (emacs-lisp-mode)
  (:default
   (:winconf 3winv)
   (:frame full)
   (:aux1 (:cmd eshell))
   (:aux2 (:buffer "*scratch*")))
  (:1
   (:winconf 2winh)
   (:frame right)))

(define-key ctl-z-map (kbd "w") 'wacspace)
(define-key ctl-z-map (kbd "C-w") 'wacspace)
(define-key ctl-z-map (kbd "s") 'wacspace-save)
(define-key ctl-z-map (kbd "C-s") 'wacspace-save)

(provide 'p-wacspace)

;;; p-wacspace.el ends here
