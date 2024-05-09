(setq treesit-language-source-alist
      '((yaml "https://github.com/ikatyang/tree-sitter-yaml")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")))

(unless (package-installed-p 'combobulate)
  (package-vc-install "https://github.com/mickeynp/combobulate"))

(unless (package-installed-p 'treesit-fold)
  (package-vc-install "https://github.com/abougouffa/treesit-fold"))

(use-package combobulate)

(provide 'p-treesitter)

;; p-treesitter.el ends here
