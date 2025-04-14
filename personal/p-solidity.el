;;; -*- lexical-binding: t -*-

(p-require-package 'solidity-mode)
(p-require-package 'solidity-flycheck)
(p-require-package 'company-solidity)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(solidity-mode . ("npx" "nomicfoundation-solidity-language-server" "--stdio" "--yes"))))

(provide 'p-solidity)

;;; p-solidity.el ends here
