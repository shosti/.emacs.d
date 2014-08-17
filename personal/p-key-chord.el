;;; -*- lexical-binding: t -*-

(p-require-package 'key-chord)

(key-chord-mode 1)

(key-chord-define global-map "xc" 'smex)
(key-chord-define global-map "XC"
                  #'(lambda ()
                      (interactive)
                      (let ((current-prefix-arg '(4)))
                        (smex))))

(provide 'p-key-chord)

;;; p-key-chord.el ends here
