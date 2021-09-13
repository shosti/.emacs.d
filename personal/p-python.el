;;; -*- lexical-binding: t -*-

(require 'p-evil)

(p-require-package 'websocket 'melpa)
(p-require-package 'jupyter 'melpa)

(setq org-babel-default-header-args:jupyter '((:async . "yes")
                                              (:session . "/jpy:localhost#8888:python3")
                                              (:kernel . "python")))

(with-eval-after-load 'org
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((emacs-lisp . t)
                                 (python . t)
                                 (jupyter . t)))
  (add-to-list 'org-src-lang-modes '("jupyter" . python)))

(provide 'p-python)
