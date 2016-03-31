;;; -*- lexical-binding: t -*-

(p-require-package 'evil-nerd-commenter)

(require 'evil-nerd-commenter)
(require 'p-leader)

(with-eval-after-load 'evil
  (define-key evil-normal-state-map ",ci" 'evilnc-comment-or-uncomment-lines)
  (define-key evil-normal-state-map ",cl" 'evilnc-quick-comment-or-uncomment-to-the-line)
  (define-key evil-normal-state-map ",ll" 'evilnc-quick-comment-or-uncomment-to-the-line)
  (define-key evil-normal-state-map ",cc" 'evilnc-copy-and-comment-lines)
  (define-key evil-normal-state-map ",cp" 'evilnc-comment-or-uncomment-paragraphs)
  (define-key evil-normal-state-map ",cr" 'comment-or-uncomment-region)
  (define-key evil-normal-state-map ",cv" 'evilnc-toggle-invert-comment-line-by-line))

(with-eval-after-load 'evil-nerd-commenter-operator
  (define-key evil-normal-state-map ",," 'evilnc-comment-operator)
  (define-key evil-visual-state-map ",," 'evilnc-comment-operator))

(with-eval-after-load 'evil
  (require 'evil-nerd-commenter-operator))

(provide 'p-evil-nerd-commenter)

;;; p-evil-nerd-commenter.el ends here
