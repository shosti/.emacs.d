;;; -*- lexical-binding: t -*-

(require 'p-display)
(require 'findr)
(require 'p-leader)
(require 'p-projectile)

;;;;;;;;;;;;
;; Config ;;
;;;;;;;;;;;;

(wacs-set-up-keys)
(setq wacs-save-frame nil)
;; Hack to get things working properly with client-server, should fix
;; properly in the future
(defun p-handle-delete-frame (&rest args)
  (message "Clearing wacspaces...")
  (wacs-clear-all-saved))

(advice-add #'server-handle-delete-frame :before #'p-handle-delete-frame)

;;;;;;;;;;;;;;;;;;;;;;
;; Helper Functions ;;
;;;;;;;;;;;;;;;;;;;;;;

(defun p-run-pry (&rest args)
  (interactive)
  (let ((buffer (apply 'wacs-make-comint "pry" "pry" nil args)))
    (switch-to-buffer buffer)
    (setq-local comint-process-echoes t)
    (setq inf-ruby-buffer buffer)))

(defun p-rails-console ()
  (interactive)
  (let ((buffer (wacs-make-comint "rails" (concat (wacs-project-dir) "bin/rails") nil
                                  "console")))
    (switch-to-buffer buffer)
    (setq-local comint-process-echoes t)
    (setq inf-ruby-buffer buffer)))

(defun p-elixir-console ()
  (interactive)
  (let ((buffer (wacs-make-comint "iex" "iex" nil "-S" "mix")))
    (switch-to-buffer buffer)
    (setq alchemist-iex-buffer buffer)
    (alchemist-iex-mode)
    (run-hooks 'alchemist-iex-mode-hook)))

(defun p-set-up-ruby-env ()
  (rbenv-use-corresponding)
  (setq inf-ruby-buffer
        (p-buffer-with-name (concat "*pry*<" (wacs-project-name) ">"))))

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
   (:aux1 wacs-eshell))
  (:1
   (:winconf 1win))
  (:2)
  (:3)
  (:4
   (:frame right)
   (:winconf 1win))
  (:5
   (:frame right)
   (:winconf 2winh))
  (:6
   (:frame right)
   (:winconf 2winh))
  (:7
   (:frame left)
   (:winconf 1win))
  (:8
   (:frame left)
   (:winconf 2winh)))

(defwacspace emacs-lisp-mode
  (:default
   (:winconf 3winv)
   (:aux2 "*scratch*"))
  (:2
   (:winconf 2winv)
   (:aux1 (:cmd
           (lambda ()
             (p-find-first-matching-file
              (concat (wacs-project-name) "-test.el")
              (wacs-project-dir))))))
  (:3
   (:winconf 2winv)
   (:aux1 (:cmd
           (lambda ()
             (p-find-first-matching-file
              (concat (wacs-project-name)
                      ".feature")
              (wacs-project-dir))))))
  (:7
   (:winconf 1win)
   (:run p-term-right)))

(defwacspace (ruby-mode projectile-rails-mode)
  (:before (lambda ()
             (rbenv-use-corresponding)
             (p-guard)
             (p-rails-console)))
  (:base-file "Gemfile")
  (:after-switch p-set-up-ruby-env)
  (:default
   (:winconf 3winv)
   (:aux2 p-rails-console))
  (:2
   (:winconf 2winv)
   (:aux1 projectile-toggle-between-implementation-and-test))
  (:3
   (:winconf 2winv)
   (:aux1 p-guard))
  (:5
   (:winconf 2winh)
   (:aux1 p-rails-console))
  (:8
   (:winconf 2winh)
   (:aux1 p-rails-console)))

(defwacspace go-mode
  (:before go-scratch)
  (:default
   (:winconf 3winv)
   (:aux2 "*go-scratch*"))
  (:2
   (:winconf 2winv)
   (:aux1 projectile-toggle-between-implementation-and-test)))

(defwacspace elixir-mode
  (:before p-elixir-console)
  (:default
   (:winconf 3winv)
   (:aux2 p-elixir-console))
  (:2
   (:winconf 2winv)
   (:aux1 projectile-toggle-between-implementation-and-test)))

(defwacspace ruby-mode
  (:before (lambda ()
             (rbenv-use-corresponding)
             (p-guard)
             (run-ruby)))
  (:default
   (:winconf 3winv)
   (:aux2 "*ruby*"))
  (:2
   (:winconf 3winv)
   (:aux1 projectile-toggle-between-implementation-and-test))
  (:3
   (:winconf 2winv)
   (:aux1 p-guard))
  (:5
   (:winconf 2winh)
   (:aux1 "*ruby*")))

(defwacspace python-mode
  (:before (lambda () (run-python python-shell-interpreter t)))
  (:default
   (:winconf 3winv)
   (:aux2 "*Python"))
  (:5
   (:winconf 2winh)
   (:aux1 "*Python")))

(defwacsaliases ((html-erb-mode projectile-rails-mode)
                 (haml-mode projectile-rails-mode)
                 (js-mode projectile-rails-mode)
                 (coffee-mode projectile-rails-mode)
                 (scss-mode projectile-rails-mode)
                 (css-mode projectile-rails-mode)
                 (feature-mode projectile-rails-mode)
                 (yaml-mode projectile-rails-mode)
                 (web-mode projectile-rails-mode))
  (ruby-mode projectile-rails-mode))

(defwacspace scala-mode
  (:before (lambda ()
             (ensime-sbt)
             (ensime-inf-switch)))
  (:base-file ".ensime")
  (:default
   (:winconf 3winv)
   (:aux1 p-scala-test-file)
   (:aux2 "*ensime-sbt*"))
  (:2
   (:winconf 2winv)
   (:aux1 p-scala-test-file))
  (:3
   (:winconf 2winv)
   (:aux1 "*ensime-inferior-scala*"))
  (:5
   (:aux1 "*ensime-inferior-scala*"))
  (:8
   (:aux1 "*ensime-inferior-scala*")))

(defwacspace (feature-mode
              (lambda ()
                (p-elisp-feature-file?)))
  (:default
   (:winconf 2winv)
   (:frame full)
   (:aux1 (lambda (
                   (p-find-first-matching-file "steps.el$"
                                               default-directory))))))

(defwacspace clojure-mode
  (:before (lambda ()
             (require 'cider)
             (unless (cider-connected-p)
               (cider-jack-in)
               (p-await 'cider-connected-p)
               (cider-scratch))))
  (:default
   (:winconf 3winv)
   (:frame full)
   (:aux1 (:cmd (lambda ()
                  (switch-to-buffer
                   (cider-current-repl-buffer)))))
   (:aux2 "*cider-scratch*"))
  (:2
   (:winconf 2winv)
   (:aux1 projectile-toggle-between-implementation-and-test)))

(defwacspace js2-jsx-mode
  (:default
   (:winconf 2winv)
   (:aux1 wacs-eshell))
  (:2
   (:winconf 3winv)
   (:aux1 p-js-switch-between-imp-and-test)
   (:aux2 wacs-eshell)))

(defwacspace pianobar-mode
  (:project-name-fn (lambda () "pianobar"))
  (:default
   (:winconf 1win)))

(defwacspace scheme-mode
  (:before (lambda ()
             (run-scheme "scheme")
             (info "sicp")))
  (:default
   (:aux1 "*scheme*"))
  (:2
   (:aux1 "*info*")))

(defwacspace restclient-mode
  (:default
   (:aux1 "*HTTP Response*")))

(p-load-private "wacspace-settings.el")

;;;;;;;;;;;;;;
;; Bindings ;;
;;;;;;;;;;;;;;

(p-set-leader-key "w" 'wacs-prefix-map)

(provide 'p-wacspace)

;;; p-wacspace.el ends here
