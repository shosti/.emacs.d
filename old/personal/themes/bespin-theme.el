;;; bespin-theme.el --- Custom face theme for Emacs

;; Copyright (C) 2010 Emanuel Evans.

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(deftheme bespin
  "Color theme ported from Bespin editor.")

(custom-theme-set-faces
 'bespin
 '(default ((t (:background "#28211C" :foreground "#BAAE9E"))))
 '(cursor ((t (:foreground "#A7A7A7"))))
 '(region ((t (:background "#1a1a1a"))))
 '(mode-line ((t (:background "white" :foreground "black"))))
 '(font-lock-builtin-face ((t (:foreground "#A6E22A"))))
 '(font-lock-comment-face ((t (:slant italic :foreground "#666666"))))
 '(font-lock-constant-face ((t (:foreground "#DDF2A4"))))
 '(font-lock-function-name-face ((t (:slant italic :foreground "#937121"))))
 '(font-lock-keyword-face ((t (:foreground "#5EA6EA"))))
 '(font-lock-string-face ((t (:foreground "#8b2252"))))
 '(font-lock-type-face ((t (:foreground "#89BDFF" :underline t))))
 '(font-lock-variable-name-face ((t (:foreground "#7587A6" :weight bold))))
 '(font-lock-warning-face ((t (:foreground "#F9EE98" :weight bold))))
 '(font-lock-doc-string-face ((t (:foreground "#5EA6EA"))))
 '(anything-file-name ((t (:foreground "Springgreen"))))
 '(anything-isearch-match ((t (:background "Black"))))
 '(custom-invalid ((((class color)) (:background "darkred" :foreground "yellow3"))))
 '(offlineimap-error-face ((t (:foreground "PaleVioletRed4" :weight bold))))
 '(offlineimap-msg-acct-face ((t (:foreground "violet"))))
 '(offlineimap-msg-syncfolders-face ((t (:foreground "darkblue"))))
 '(offlineimap-msg-syncingmessages-face ((t (:foreground "darkblue"))))
 '(org-hide ((((background dark)) (:foreground "#28211C"))))
 '(undo-tree-visualizer-current-face ((((class color)) (:foreground "palevioletred"))))
 '(w3m-form ((((class color) (background dark)) (:foreground "palevioletred" :underline t))))
 '(which-func ((((class color) (min-colors 88) (background dark)) (:foreground "Blue4"))))
 '(widget-button-pressed ((((min-colors 88) (class color)) (:foreground "purple1"))))
 '(elscreen-tab-background-face ((t (:background "#999999"))))
 '(elscreen-tab-control-face ((t (:background "black" :foreground "#BAAE9E"))))
 '(elscreen-tab-current-screen-face ((t (:background "#28211C" :foreground "#BAAE9E"))))
 '(elscreen-tab-other-screen-face ((t (:background "black" :foreground "#BAAE9E" :underline nil)))))


(provide-theme 'bespin)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; bespin-theme.el  ends here
