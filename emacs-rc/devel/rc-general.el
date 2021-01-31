;;; rc-general.el ---
;;
;; Filename: rc-general.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:01:36 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Вс янв 31 22:42:07 2021 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 45
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

(custom-set-variables
 '(indent-tabs-mode nil)
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

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin/")))

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell
      (replace-regexp-in-string "[[:space:]\n]*$" ""
        (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when (equal system-type 'darwin) (set-exec-path-from-shell-PATH))

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
  (compile compile-command)
  (message "make executed!"))

(defun user-make-clean ()
  "save and clean build"
  (interactive)
  (compile "make clean")
  (message "make clean executed!"))

(global-set-key (kbd "\C-cn") 'user-make-clean)
(global-set-key (kbd "\C-cm") 'user-save-and-make-all)

;;
;; Line numbers on
;;

(require 'display-line-numbers)

(defcustom display-line-numbers-exempt-modes
  '(vterm-mode eshell-mode shell-mode term-mode ansi-term-mode)
  "Major modes on which to disable the linum mode, exempts them from global requirement"
  :group 'display-line-numbers
  :type 'list
  :version "green")

(global-display-line-numbers-mode)

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

(setq show-paren-delay 0)
(show-paren-mode 1)

(require 'paren)

(set-face-background 'show-paren-match "#00BB00")
(set-face-foreground 'show-paren-match "#BB0000")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

(set-face-attribute 'show-paren-match nil
                    :weight 'bold :underline nil :overline nil
                    :slant 'normal)
(set-face-foreground 'show-paren-mismatch "#BB0000")
(set-face-attribute 'show-paren-mismatch nil
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

;; (require 'highlight-indentation)

;; (set-face-background 'highlight-indentation-face "#e3e3d3")
;; (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")

;; Highlight indentation symbols
(require 'highlight-chars)

(set-face-background 'hc-tab "#BB0000")

(defun highlight-indent-chars ()
  (interactive)
  (if (null hc-highlight-tabs-p)
      (message "Highlighting tabs")
    (message "Turning highlight mode off"))
  (hc-toggle-highlight-tabs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-general.el ends here
