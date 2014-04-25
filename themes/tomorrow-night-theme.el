;;; -*- lexical-binding: t -*-

;;; tomorrow-night-theme.el --- Custom face theme for Emacs

;; Copyright (C) 2010 .

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

(deftheme tomorrow-night
  "Port to Emacs 24 of the Tomorrow Night theme")

(let ((background   "#1d1f21")
      (cursor       "#aeafad")
      (current-line "#282a2e")
      (selection    "#373b41")
      (foreground   "#c5c8c6")
      (comment      "#969896")
      (red          "#cc6666")
      (orange       "#de935f")
      (yellow       "#f0c674")
      (green        "#b5bd68")
      (aqua         "#8abeb7")
      (blue         "#81a2be")
      (purple       "#b294bb"))

  (custom-theme-set-faces
   'tomorrow-night
   `(default ((t (:background ,background :foreground ,foreground))))
   `(region ((t (:background ,selection))))
   `(cursor ((t (:foreground ,cursor))))
   `(mode-line ((t (:background ,current-line :foreground ,foreground))))
   `(fringe ((t (:background ,current-line))))
   `(minibuffer-prompt ((t (:foreground ,blue))))

   ;; Font-lock stuff
   `(font-lock-comment-face ((t (:foreground ,comment))))
   `(font-lock-constant-face ((t (:foreground ,green))))
   `(font-lock-doc-string-face ((t (:foreground ,comment))))
   `(font-lock-function-name-face ((t (:foreground ,blue))))
   `(font-lock-keyword-face ((t (:foreground ,purple))))
   `(font-lock-builtin-face ((t (:foreground ,purple))))
   `(font-lock-string-face ((t (:foreground ,green))))
   `(font-lock-type-face ((t (:foreground ,yellow))))
   `(font-lock-variable-name-face ((t (:foreground ,red))))
   `(font-lock-warning-face ((t (:foreground ,red))))

   ;; linum
   `(linum ((t (:background ,current-line :foreground ,foreground))))

   ;; elscreen
   `(elscreen-tab-control-face ((t (:foreground ,foreground
                                                :background ,current-line))))
   `(elscreen-tab-background-face ((t (:background ,foreground))))
   `(elscreen-tab-current-screen-face
     ((t
       (:foreground ,foreground
                    :background ,background))))
   `(elscreen-tab-other-screen-face ((t (:foreground ,background
                                                     :background ,comment))))

   ;; hl-line-mode
   `(hl-line ((t (:background ,current-line))))

   ;; links
   `(link ((t (:foreground ,aqua :underline t))))

   ;; org-mode
   `(org-date ((t (:foreground ,purple))))
   `(org-done ((t (:foreground ,green))))
   `(org-hide ((t (:foreground ,background))))
   `(org-link ((t (:foreground ,aqua :underline t))))
   `(org-todo ((t (:foreground ,red))))

   ;; show-paren-mode
   `(show-paren-match-face ((t (:foreground ,blue))))
   `(show-paren-mismatch-face ((t (:background ,orange
                                               :foreground ,current-line))))

   ;; whitespace mode
   `(whitespace-space ((t (:background ,background
                                       :foreground ,current-line))))
   `(whitespace-line ((t (:foreground ,red :background ,selection))))

   ;; ace-jump
   `(ace-jump-face-foreground ((t (:foreground ,red))))
   `(ace-jump-face-background ((t (:foreground ,selection))))

   ;; helm
   `(helm-selection ((t :background ,selection :underline nil)))
   `(helm-source-header ((t :foreground ,blue :background ,current-line :underline t)))

   ;;ido-mode
   `(ido-subdir ((t (:foreground ,red))))
   `(ido-indicator ((t (:foreground ,yellow :background ,red))))
   `(ido-only-match ((t (:foreground ,green))))

   ;; flyspell
   `(flyspell-incorrect-face ((t (:foreground ,red :underline t))))

   ;; parenface
   `(p-paren-face
     ((t (:foreground "#464B51"))))

   ;; magit
   `(magit-item-highlight ((t (:background ,current-line))))

   ;; jabber
   `(jabber-activity-face ((t (:foreground ,red))))
   `(jabber-activity-personal-face ((t (:foreground ,blue))))
   `(jabber-rare-time-face ((t (:foreground ,green))))
   `(jabber-chat-prompt-local ((t (:foreground ,blue :weight bold))))
   `(jabber-chat-prompt-foreign ((t (:foreground ,red :weight bold))))
   `(jabber-chat-prompt-system ((t :foreground ,green :weight bold)))
   `(jabber-chat-error ((t (:foreground ,red :weight bold))))
   `(jabber-roster-user-online ((t (:foreground ,blue :weight bold :slant normal))))
   `(jabber-roster-user-xa ((t (:foreground ,purple :weight normal :slant italic))))
   `(jabber-roster-user-dnd ((t (:foreground ,red :weight normal :slant italic))))
   `(jabber-roster-user-away ((t (:foreground ,green :weight normal :slant italic))))
   `(jabber-roster-user-chatty ((t (:foreground ,orange :weight bold :slant normal))))
   `(jabber-roster-user-error ((t (:foreground ,red :weight light :slant italic))))
   `(jabber-roster-user-offline ((t (:foreground ,aqua :weight light :slant italic))))

   ;; misc
   `(isearch ((t (:background ,yellow :foreground ,red))))
   `(isearch-fail ((t (:background ,red :foreground ,foreground)))))

  (custom-theme-set-variables
   'tomorrow-night

   `(ansi-color-names-vector
     ;; black, red, green, yellow, blue, magenta, cyan, white
     [,background ,red ,green ,yellow ,blue ,purple ,blue ,foreground])
   `(ansi-term-color-vector
     ;; black, red, green, yellow, blue, magenta, cyan, white
     [unspecified ,background ,red ,green ,yellow ,blue ,purple ,blue ,foreground])
   `(hl-paren-colors
     '(,red ,orange ,yellow ,green)))

  (eval-after-load 'diff-mode
    `(progn
       (set-face-foreground 'diff-added ,green)
       (set-face-foreground 'diff-removed ,red)))

  (eval-after-load 'magit
    `(progn
       (set-face-foreground 'magit-diff-add ,green)
       (set-face-foreground 'magit-diff-del ,red))))

(provide-theme 'tomorrow-night)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; tomorrow-night-theme.el  ends here
