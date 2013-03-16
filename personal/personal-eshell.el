(require 'eshell)
(require 'dirtrack)

(setq eshell-scroll-to-bottom-on-input t)
(setq eshell-scroll-show-maximum-output nil)
(setq eshell-directory-name (concat personal-dir "/eshell/"))

(personal-path-from-file "~/.path")

(setenv "TERM" "dumb")
(setenv "EDITOR" "emacsclient")
(setenv "PAGER" "cat")
(setenv "NODE_PATH" "/usr/local/lib/node")
(setenv "CLASSPATH"
        "/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar")
(setenv "PYTHONPATH"
        "/usr/local/lib/python2.7/site-packages")

(add-hook 'eshell-mode-hook
          (lambda ()
            (setq eshell-path-env (getenv "PATH"))
            ;;hack--not sure why it doesn't actually work
            (visual-line-mode 0)
            (dirtrack-mode 1)))

(eshell)
(setq eshell-visual-commands
      (append eshell-visual-commands '("mu" "sl")))

(provide 'personal-eshell)
