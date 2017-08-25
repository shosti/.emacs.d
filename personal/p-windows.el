(when (eq system-type 'windows-nt)
  ;; Go-specific hacks
  (add-to-list 'exec-path (expand-file-name "~/go/bin"))
  (setenv "PATH" (mapconcat 'identity exec-path ";")))

(provide 'p-windows)

;;; p-windows.el ends here
