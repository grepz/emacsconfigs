;;; rc-general.el --- 

;; Copyright (C) 2012  Stanislav M. Ivankin

;; Author: Stanislav M. Ivankin <stas@concat.info>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

;; Line numbers
(require 'linum)
;; Emacs tags
;;(require 'etags)

(custom-set-variables 
 '(compilation-scroll-output 1)
 '(compilation-window-height 20)
 '(fill-column 78)
 '(cscope-do-not-update-database t)
 '(flymake-no-changes-timeout 3)
 '(flymake-start-syntax-check-on-newline nil)
 '(flymake-start-syntax-check-on-find-file nil)
 '(gdb-many-windows t)
 '(gdb-use-separate-io-buffer nil)
 '(show-paren-style 'parenthesis))

(add-hook
 'after-save-hook
 #'(lambda ()
     (save-r/e/md
      (widen)
      (goto-char (point-min))
      (when (looking-at "^#!")
	(change-execution-bit)))))

(defun user-save-and-make-all ()
  "save and call compile as make all"
  (interactive)
  (save-buffer)
  (compile "make all")
  (message "make all executed!"))

(defun user-make-clean ()
  "save and clean build"
  (interactive)
  (compile "make clean")
  (message "make clean executed!"))

(global-set-key (kbd "\C-cn") 'user-make-clean)
(global-set-key (kbd "\C-cm") 'user-save-and-make-all)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fontlocking keywords ;;

;; Make special keywords colorfull, just like in vim.
;; TODO: User friendly interface

(eval-and-compile
  (defvar warn-keywords   '("FIXME" "WARN" "ERR" "BUG"))
  (defvar notice-keywords '("TODO" "XXX" "NOTE")))

(make-my-face 'my-warn-face "red" "white" t)
(make-my-face 'my-notice-face "yellow" "black" t)

(dolist (mode '(c-mode c++-mode cperl-mode sh-mode
		slime-mode emacs-lisp-mode lisp-mode
		tuareg-mode haskell-mode python-mode))
  (add-fontlocked-keywords mode warn-keywords 'my-warn-face)
  (add-fontlocked-keywords mode notice-keywords 'my-notice-face))

;;;;;;;;;;;;;;;;;;;;;;;;
;; 80 characters long ;;

(require 'highlight-80+)

(dolist (hook '(python-mode-hook
		emacs-lisp-mode-hook
		c-mode-common-hook 
	        tuareg-mode-hook))
  (add-hook hook 'highlight-80+-mode))

;;;;;;;;;;;
;; Paren ;;

(show-paren-mode 1)

(set-face-background 'show-paren-match-face "#BBBBBB")
(set-face-attribute 'show-paren-match-face nil 
		    :weight 'bold :underline nil :overline nil
		    :slant 'normal)
(set-face-foreground 'show-paren-mismatch-face "red")
(set-face-attribute 'show-paren-mismatch-face nil 
                    :weight 'bold :underline nil :overline nil
		    :slant 'normal)
;;;;;;;;;;;;;;;;
;; Prerrt lambda's ;;

(require 'pretty-lambdada)
(pretty-lambda-for-modes)
(pretty-lambda 'emacs-lisp-mode)
(pretty-lambda 'tuareg-mode)

;;;;;;;;;;;
;; CMake ;;

(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt$" . cmake-mode))

;;;;;;;;;;;;;;;;;;;;;
;; Rev Con systems ;;

(require 'vc)
(require 'vc-git)

(when (featurep 'vc-git)
  (add-to-list 'vc-handled-backends 'git))

(require 'magit)
(autoload 'magit-status "magit" nil t)

(provide 'rc-general)
;;; rc-general.el ends here
