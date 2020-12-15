;;; -*- lexical-binding: t -*-

(p-require-package 'projectile)

(require 'p-key-chord)

(setq projectile-keymap-prefix (kbd "C-c p")
      projectile-test-suffix-function #'p-projectile-test-suffix
      projectile-test-prefix-function #'p-projectile-test-prefix)

(with-eval-after-load 'projectile
  (add-to-list 'projectile-project-root-files-top-down-recurring "BUILD.bazel")
  (projectile-register-project-type 'elixir '("mix.exs")))

(defun p-projectile-test-suffix (project-type)
  "Find default test files suffix based on PROJECT-TYPE."
  (cond
   ((member project-type '(rails-rspec ruby-rspec)) "_spec")
   ((member project-type '(rails-test ruby-test lein-test go elixir)) "_test")
   ((member project-type '(scons)) "test")
   ((member project-type '(maven symfony)) "Test")
   ((member project-type '(gradle grails)) "Spec")))

(defun p-projectile-test-prefix (project-type)
  "Find default test files prefix based on PROJECT-TYPE."
  (cond
   ((member project-type '(javascript)) "__tests__/")))

(projectile-global-mode)

(provide 'p-projectile)

;;; p-projectile.el ends here
