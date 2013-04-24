(add-to-list 'load-path (expand-file-name "~/src/wacspace"))

(require 'wacspace)
(require 'p-bindings)
(require 'p-display)
(require 'scala-mode2)
(require 'ensime)
(require 'findr)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;


(wacs-set-frame-fn full p-display-fill-screen)
(wacs-set-frame-fn right p-display-right-half)
(wacs-set-frame-fn left p-display-left-half)

;;;;;;;;;;;;;;;;;;;;;;
;; Helper Functions ;;
;;;;;;;;;;;;;;;;;;;;;;

(defun p-find-first-matching-file (name dir)
  (-> name
    (findr dir)
    (car)
    (find-file)))

(defun p-scala-test-file ()
  (p-find-first-matching-file "Suite.scala$"
                              (concat (wacs-project-dir)
                                      "src/test/scala")))

(defun p-elisp-feature-file? ()
  (file-exists-p
   (concat (p-trim-until-regexp default-directory
                                "features")
           "Carton")))

;;;;;;;;;;;;;;;
;; Wacspaces ;;
;;;;;;;;;;;;;;;

(defwacspace (scala-mode)
  (:before (lambda ()
             (ensime-sbt)
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
   (:frame right)
   (:aux1 (:cmd wacs-eshell)))
  (:3
   (:winconf 2winh)
   (:frame right)
   (:aux1 (:buffer "*guard*"))))

(defwacspace (emacs-lisp-mode)
  (:default
   (:winconf 3winv)
   (:frame full)
   (:aux1 (:cmd wacs-eshell))
   (:aux2 (:buffer "*scratch*")))
  (:1
   (:winconf 2winh)
   (:frame right)))

(defwacspace (feature-mode
              (lambda ()
                (p-elisp-feature-file?)))
  (:default
   (:winconf 2winv)
   (:frame full)
   (:aux1 (:cmd (lambda ()
                  (p-find-first-matching-file "steps.el$"
                                              default-directory))))))

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;


(define-key ctl-z-map (kbd "w") 'wacspace)
(define-key ctl-z-map (kbd "C-w") 'wacspace)
(define-key ctl-z-map (kbd "s") 'wacspace-save)
(define-key ctl-z-map (kbd "C-s") 'wacspace-save)

(provide 'p-wacspace)

;;; p-wacspace.el ends here
