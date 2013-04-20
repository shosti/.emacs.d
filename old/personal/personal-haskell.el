(require 'personal-packages)

(let ((ghc-dir "/Users/eman/.cabal/share/ghc-mod-1.10.17"))
  (when (file-exists-p ghc-dir)
    (add-to-list 'load-path ghc-dir)
    (autoload 'ghc-init "ghc" nil t)
    (add-hook 'haskell-mode-hook
              '(lambda ()
                 (ghc-init)))))
