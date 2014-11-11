;;; rc-general.el ---
;;
;; Filename: rc-general.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:01:36 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Tue Nov 11 16:15:49 2014 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 9
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


;; Line numbers
(require 'linum)

(custom-set-variables
 '(compilation-scroll-output 1)
 '(compilation-window-height 20)
 '(fill-column 80)
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

;;
;; Fill column
;;

(require 'fill-column-indicator)
(setq fci-rule-width 1)
(setq fci-rule-color "#555555")

;;
;; Fontlocking keywords
;;

;; Make special keywords colored

(eval-and-compile
  (defvar warn-keywords   '("FIXME" "WARN" "ERR" "BUG"))
  (defvar notice-keywords '("XXX" "NOTE"))
  (defvar todo-keywords   '("TODO")))

(make-my-face 'my-warn-face   "red"    "white" t)
(make-my-face 'my-notice-face "green"  "black" t)
(make-my-face 'my-todo-face   "yellow" "black" t)

(dolist (mode '(c-mode c++-mode cperl-mode sh-mode erlang-mode
					   slime-mode emacs-lisp-mode lisp-mode
					   tuareg-mode haskell-mode python-mode))
  (add-fontlocked-keywords mode warn-keywords 'my-warn-face)
  (add-fontlocked-keywords mode notice-keywords 'my-notice-face)
  (add-fontlocked-keywords mode todo-keywords 'my-todo-face))

;;
;; whitespace
;;

(require 'whitespace)

(setq whitespace-style '(face empty trailing))

(global-whitespace-mode 1)

;;
;; Paren
;;

(show-paren-mode 1)

(set-face-background 'show-paren-match-face "#00BB00")
(set-face-attribute 'show-paren-match-face nil
					:weight 'bold :underline nil :overline nil
					:slant 'normal)
(set-face-foreground 'show-paren-mismatch-face "#BB0000")
(set-face-attribute 'show-paren-mismatch-face nil
                    :weight 'bold :underline nil :overline nil
					:slant 'normal)
;;
;; Pretty lambda's
;;

;;lisp--prettify-symbols-alist

(global-prettify-symbols-mode 1)

;;
;; General revision systems setup
;;

(require 'vc)
(require 'vc-git)

(when (featurep 'vc-git)
  (add-to-list 'vc-handled-backends 'git))

;;
;; Magit
;;

(require 'magit)
(autoload 'magit-status "magit" nil t)

;; Turn on ANSI colors in make buffer
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (read-only-mode)
  (ansi-color-apply-on-region (point-min) (point-max))
  (read-only-mode))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;;
;; Neotree
;;

(add-to-list 'load-path "~/elisp/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


;;
;; Cedet
;;

(global-ede-mode t)
(semantic-mode t)

(setq semantic-default-submodes
      '(global-semanticdb-minor-mode
		global-semantic-idle-scheduler-mode
		global-semantic-idle-summary-mode
		global-semantic-decoration-mode
		global-semantic-highlight-func-mode
		global-semantic-stickyfunc-mode
		global-semantic-mru-bookmark-mode
		global-semantic-idle-local-symbol-highlight-mode))

;;
;; Cedet
;;

(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(require 'xcscope)
;;(require 'xcscope+)

(define-key global-map [(control f3)]  'cscope-set-initial-directory)
(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
(define-key global-map [(control f5)]  'cscope-find-this-symbol)
(define-key global-map [(control f6)]  'cscope-find-global-definition)
(define-key global-map [(control f7)]  'cscope-find-global-definition-no-prompting)
(define-key global-map [(control f8)]  'cscope-pop-mark)
(define-key global-map [(control f9)]  'cscope-next-symbol)
(define-key global-map [(control f10)] 'cscope-next-file)
(define-key global-map [(control f11)] 'cscope-prev-symbol)
(define-key global-map [(control f12)] 'cscope-prev-file)
(define-key global-map [(meta f9)]  'cscope-display-buffer)
(define-key global-map [(meta f10)] 'cscope-display-buffer-toggle)

;;
;; Header2
;;

;; make-header to make one interactevly

(require 'header2)

(add-hook 'before-save-hook 'update-file-header)

(provide 'rc-general)
;;; rc-general.el ends here

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-general.el ends here
