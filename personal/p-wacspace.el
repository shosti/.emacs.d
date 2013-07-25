(p-require-package 'wacspace 'local)

(require 'p-display)
(require 'findr)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(wacs-set-up-keys)
(wacs-set-frame-fn full p-display-fill-screen)
(wacs-set-frame-fn right p-display-right-half)
(wacs-set-frame-fn left p-display-left-half)

;;;;;;;;;;;;;;;;;;;;;;
;; Helper Functions ;;
;;;;;;;;;;;;;;;;;;;;;;

(defun p-run-pry (&rest args)
  (interactive)
  (let ((buffer (apply 'wacs-make-comint "pry" "pry" nil args)))
    (switch-to-buffer buffer)
    (setq-local comint-process-echoes t)))

(defun p-rails-console ()
  (interactive)
  (p-run-pry "-r" "./config/environment"
             "-r" "rails/console/app"
             "-r" "rails/console/helpers"))

(defun p-compilation-buffer (name cmd &rest args)
  (interactive)
  (let ((buffer
         (apply 'wacs-make-comint name cmd nil args)))
    (switch-to-buffer buffer)
    (compilation-shell-minor-mode 1)))

(defun p-find-first-matching-file (name dir)
  (--if-let (-> name
              (findr dir)
              (car))
    (find-file it)
    (wacs-eshell)))

(defun p-scala-test-file ()
  (p-find-first-matching-file "Suite.scala$"
                              (concat (wacs-project-dir)
                                      "src/test/scala")))

(defun p-elisp-feature-file? ()
  (file-exists-p
   (concat (p-keep-until-regexp default-directory
                                "features")
           "Carton")))

(defun p-chrome-left ()
  (p-run-applescript "chrome-left"))

(defun p-term-right ()
  (p-run-applescript "term_right"))

;;;;;;;;;;;;;;;
;; Wacspaces ;;
;;;;;;;;;;;;;;;

;; My basic configuration scheme is as follows:
;; Default: Full-screen overview (eshell, compilation, etc.)
;; 1. Full-screen focus
;; 2. Full-screen test
;; 3. Full-screen repl
;; 4. Right-screen focus
;; 5. Right-screen repl
;; 6. Left-screen focus
;; 7. Left-screen repl

(defwacspace :default
  (:default
   (:winconf 2winv)
   (:frame full)
   (:aux1 (:cmd wacs-eshell)))
  (:1
   (:winconf 1win))
  (:2)
  (:3)
  (:4
   (:frame right)
   (:winconf 1win)
   (:run p-chrome-left))
  (:5
   (:frame right)
   (:winconf 2winh)
   (:run p-chrome-left))
  (:6
   (:frame left)
   (:winconf 1win))
  (:7
   (:frame left)
   (:winconf 2winh)))

(defwacspace emacs-lisp-mode
  (:default
   (:winconf 3winv)
   (:aux2 (:buffer "*scratch*")))
  (:2
   (:winconf 2winv)
   (:aux1 (:cmd
           (lambda ()
             (p-find-first-matching-file
              "unit-tests.el"
              (wacs-project-dir))))))
  (:3
   (:winconf 2winv)
   (:aux1 (:cmd
           (lambda ()
             (p-find-first-matching-file
              (concat (wacs-project-name)
                      ".feature")
              (wacs-project-dir))))))
  (:6
   (:winconf 1win)
   (:run p-term-right)))

(defwacspace (ruby-mode rinari-minor-mode)
  (:base-file "Gemfile")
  (:after-switch rbenv-use-corresponding)
  (:default
   (:winconf 3winv)
   (:aux2 (:cmd p-foreman)))
  (:2
   (:winconf 2winv)
   (:aux1 (:cmd rinari-find-rspec)))
  (:3
   (:winconf 2winv)
   (:aux1 (:cmd p-rails-console)))
  (:5
   (:winconf 2winh)
   (:aux1 (:cmd p-rails-console)))
  (:7
   (:winconf 2winh)
   (:aux1 (:cmd p-rails-console))))

(defwacspace ruby-mode
  (:before run-ruby)
  (:after-switch rbenv-use-corresponding)
  (:default
   (:aux1 (:buffer "*ruby*"))))

(defwacspace python-mode
  (:before (lambda () (run-python python-shell-interpreter t)))
  (:default
   (:winconf 3winv)
   (:aux2 (:buffer "*Python")))
  (:5
   (:winconf 2winh)
   (:aux1 (:buffer "*Python"))))

(defwacsaliases ((html-erb-mode rinari-minor-mode)
                 (haml-mode rinari-minor-mode)
                 (js-mode rinari-minor-mode)
                 (coffee-mode rinari-minor-mode)
                 (scss-mode rinari-minor-mode)
                 (css-mode rinari-minor-mode)
                 (feature-mode rinari-minor-mode)
                 (yaml-mode rinari-minor-mode))
  (ruby-mode rinari-minor-mode))

(defwacspace scala-mode
  (:before (lambda ()
             (ensime-sbt)
             (ensime-inf-switch)))
  (:base-file ".ensime")
  (:default
   (:winconf 3winv)
   (:aux1 (:cmd p-scala-test-file))
   (:aux2 (:buffer "*ensime-sbt*")))
  (:2
   (:winconf 2winv)
   (:aux1 (:cmd p-scala-test-file)))
  (:3
   (:winconf 2winv)
   (:aux1 (:buffer "*ensime-inferior-scala*")))
  (:5
   (:aux1 (:buffer "*ensime-inferior-scala*")))
  (:7
   (:aux1 (:buffer "*ensime-inferior-scala*"))))

(defwacspace (feature-mode
              (lambda ()
                (p-elisp-feature-file?)))
  (:default
   (:winconf 2winv)
   (:frame full)
   (:aux1 (:cmd (lambda ()
                  (p-find-first-matching-file "steps.el$"
                                              default-directory))))))

(defwacspace (clojure-mode nrepl-interaction-mode)
  (:default
   (:winconf 2winv)
   (:frame full)
   (:aux1 (:buffer "*nrepl*")))
  (:2
   (:aux1 (:cmd clojure-jump-to-test))))

(defwacspace erc-mode
  (:project-name-fn (lambda () "erc"))
  (:default
   (:winconf 4win)
   (:frame full)
   (:main (:buffer "#emacs"))
   (:aux1 (:buffer "#clojure"))
   (:aux2 (:buffer "#rubyonrails"))
   (:aux3 (:buffer "#ruby"))))

(provide 'p-wacspace)

;;; p-wacspace.el ends here
