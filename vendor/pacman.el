;; FILE: /home/syrinx/conf-scripts/emacs-dir/custom-modes/pacman-mode.el
;; AUTHOR: Brandon Betances (Copyleft 2012)

;;  This program is free software; you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation; either version 2 of the License, or
;;  (at your option) any later version.

;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.

;;  You should have received a copy of the GNU General Public License
;;  along with this program; if not, write to the Free Software
;;  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

;; This mode will allow for interaction with the Archlinux package manager, pacman.

;; The author can be contacted at : <syrinx.optimised@gmail.com>

;; Most of this is based off apt-mode, written by Junichi Uekawa. Thank you, Junichi.
;; Apt-mode can be found here: http://www.netfort.gr.jp/~dancer/software/apt-mode.html

;; NOTE: this file uses @matthew-ball's custom comments system, available here:
;; NOTE: https://github.com/matthew-ball/config-scripts/tree/master/emacs-dir/my-modes

;; COMMENT: some base variables
(defvar superuser-command-string "sudo"
  "This variable defines the superuser command for running pacman.
In this case, sudo. This is noninteractive.")
(defvar package-manager "pacman"
  "This variable defines the pacman command. This will probably always be 'pacman'.")

;; COMMENT: create the pacman-mode buffer
(defun pacman ()
  "Create a new buffer with pacman-mode"
  (interactive)
  (switch-to-buffer "*pacman-mode*")
  (kill-region (point-min) (point-max))
  (pacman-mode)
  (insert
   "Pacman front-end for Emacs\n\n"
   "Copyright 2012 Brandon Betances\n\n"
   "\ts - Search (pacman -Ss *package*)\n"
   "\ti - Install (pacman -S *package*)\n"
   "\tr - Remove (pacman -R *package*)\n"
   "\tl - List installed packages (pacman -Q)\n"
   "\td - Details of package (pacman -Si *package*)\n"
   "\ty - Sync package databases (pacman -Syy)\n"
   "\tu - Update system (pacman -Syu)\n"
   "\tq - Quit\n"
   )
  )

;; COMMENT: pacman major-mode
(defun pacman-mode ()
  "Major mode for pacman.
Special commands:
\\{pacman-mode-map}
  Turning on `pacman-mode' runs the hook `pacman-mode-hook'."
  (interactive)
  (kill-all-local-variables)
  (use-local-map pacman-mode-map)
  (setq mode-name "Pacman")
  (setq major-mode 'pacman-mode)
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
	'(
					;keywords start here
	  (("^\\([^ ]*\\) - \\(.*\\)$" (1 font-lock-warning-face) (2 font-lock-keyword-face)))
	  nil		;keywords-only
	  nil		;case-fold
	  ()		;syntax-alist
	  ))
  (run-hooks 'pacman-mode-hook))

(defvar pacman-mode-map nil ;; NOTE: Create a mode-specific keymap.
  "Keymap for pacman-mode.")

;; COMMENT: keybindingd7
(if pacman-mode-map
    ()
  (setq pacman-mode-map (make-sparse-keymap))
  (define-key pacman-mode-map "s" 'pacman-mode-search)
  (define-key pacman-mode-map "i" 'pacman-mode-install)
  (define-key pacman-mode-map "r" 'pacman-mode-remove)
  (define-key pacman-mode-map "l" 'pacman-mode-list-installed-packages)
  (define-key pacman-mode-map "d" 'pacman-mode-package-details)
  (define-key pacman-mode-map "y" 'pacman-mode-sync)
  (define-key pacman-mode-map "u" 'pacman-mode-update)
  (define-key pacman-mode-map "q" 'pacman-mode-kill-buffer)

  )

;; COMMENT: search for packages function
(defun pacman-mode-search ()
  "Search function for pacman. Searches the package database with a regex."
  (interactive)
  (let* ((searchstring (read-string "Search pacman: "))
	 (searchbuffer (concat "*pacman-search-" searchstring "*"))
	 (searchcommand (concat "-Ss"))
	 )
    (switch-to-buffer searchbuffer)
    (pacman-mode)
    (kill-region (point-min) (point-max))
    (call-process superuser-command-string nil
		  searchbuffer
		  nil package-manager searchcommand searchstring)
    ))

;; COMMENT: install package function
(defun pacman-mode-install ()
  "This function installs a package from pacman. Equivelant to *pacman -S 'package'*."
  (interactive)
  (let* ((installstring (read-string "Package to install: "))
	 (installbuffer (concat "*pacman-install-" installstring "*"))
	 (installprocess (concat "installprocess"))
	 (installcommand (concat "-S"))
	 )
    (switch-to-buffer installbuffer)
    (pacman-mode)
    (kill-region (point-min) (point-max))
    (start-process-shell-command installprocess
				 installbuffer
				 superuser-command-string
				 package-manager installcommand installstring)
    (if (y-or-n-p (concat "Install " installstring "? "))
	(progn
	  (process-send-string installprocess "y\n"))
      (progn
	(delete-process installprocess)))
    )
  )

;; COMMENT: remove package function
(defun pacman-mode-remove ()
  "This function removes a package from the system. Equivalent to *pacman -R 'package'*."
  (interactive)
  (let* ((removestring (read-string "Package to uninstall: "))
	 (removebuffer (concat "*pacman-remove-" removestring "*"))
	 (removeprocess (concat "removeprocess"))
	 (removecommand (concat "-R"))
	 )
    (switch-to-buffer removebuffer)
    (pacman-mode)
    (kill-region (point-min) (point-max))
    (start-process-shell-command removeprocess
				 removebuffer
				 superuser-command-string
				 package-manager removecommand removestring)
    (if (y-or-n-p (concat "Remove " removestring "?"))
	(process-send-string removeprocess "y\n")
      (delete-process removeprocess))
    )
  )

;; COMMENT: pacman list installed packages function
(defun pacman-mode-list-installed-packages ()
  "This function lists all installed packages. Equivalent to *pacman -Q*."
  (interactive)
  (let* ((installedbuffer (concat "*pacman-installed-packages*"))
	 (installedcommand (concat "-Q"))
	 )
    (switch-to-buffer installedbuffer)
    (pacman-mode)
    (kill-region (point-min) (point-max))
    (call-process superuser-command-string nil
		  installedbuffer t
		  package-manager installedcommand)
    )
  )

;; COMMENT: pacman details of *package* function
(defun pacman-mode-package-details ()
  "This function displays information about an installed package. Equivalent to *pacman -Si 'package'*."
  (interactive)
  (let* ((detailsstring (read-string "Details of which package? "))
	 (detailsbuffer (concat "*pacman-package-details*"))
	 (detailscommand (concat "-Si"))
	 )
    (switch-to-buffer detailsbuffer)
    (pacman-mode)
    (kill-region (point-min) (point-max))
    (call-process superuser-command-string nil
		  detailsbuffer t
		  package-manager detailscommand detailsstring)
    )
  )

;; COMMENT: pacman update function
;; BUG: this works, but it's pretty ugly. The output is horrendous, for some reason, and it looks very "hacky"
(defun pacman-mode-update ()
  "pacman update system command, using sudo to gain root."
  (interactive)
  (let* ((updatebuffer (concat "*pacman-update*"))
	 (updateprocess (concat "updateprocess"))
	 (updatecommand (concat "-Syu"))
	 )
    (switch-to-buffer updatebuffer)
    (pacman-mode)
    (kill-region (point-min) (point-max))
    (start-process-shell-command updateprocess 
				 updatebuffer
				 superuser-command-string 
				 package-manager updatecommand)
    (if (y-or-n-p "Continue updating system? ")
	(progn
	  (process-send-string updateprocess "y\n"))
      (progn
	(delete-process updateprocess)))
    )
  )

;; COMMENT: pacman sync function
(defun pacman-mode-sync ()
  "This function syncs the package databases. Equivalent to *pacman -Syy*."
  (interactive)
  (let* ((syncbuffer (concat "*pacman-sync*"))
	 (synccommand (concat "-Syy"))
	 )
    (switch-to-buffer syncbuffer)
    (pacman-mode)
    (kill-region (point-min) (point-max))
    (call-process superuser-command-string nil
		  syncbuffer t
		  package-manager synccommand)
    (insert "Package databases synced.")
    )
  )

;; COMMENT: kill pacman-mode
(defun pacman-mode-kill-buffer ()
  "Kill the pacman-mode buffer."
  (interactive)
  (kill-buffer (current-buffer))
)

(provide 'pacman)
