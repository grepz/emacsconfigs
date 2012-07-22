;;; rc-lang.el --- 

;; Copyright (C) 2012  

;; Author:  <esgal@eternote>
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OCaml
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CC-Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cwarn)

(setq auto-mode-alist (cons '("\\.h\\'" . c++-mode) auto-mode-alist))

(defconst use-backup-dir t)

(c-add-style "k&r-2" '("k&r" (intent-tabs-mode . nil) (c-basic-offset . 4)))
(setq c-default-style "k&r-2")

(setq require-final-newline t)

(defun my-c-mode-common-hook ()
;;       (c-set-offset 'member-init-intro '++)
       (setq show-trailing-whitespace t)
       (setq indent-tabs-mode nil)
       (nlinum-mode 1)
       (c-toggle-auto-hungry-state 1)
;;       (abbrev-mode 1)
       (auto-fill-mode 1)
       (cwarn-mode 1)
       (local-set-key [delete] 'delete-char)
       (local-set-key [return] 'newline-and-indent)
       (local-set-key (kbd "s-g") 'gdb-restore-windows)
       (local-set-key "\C-hf" 'woman))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Erlang
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "/usr/lib/erlang/lib/tools-2.6.7/emacs/")

(load "/usr/lib/erlang/lib/tools-2.6.7/emacs/erlang-start.el")

(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

(setq-default erlang-root-dir "/usr/lib/erlang")
(setq-default erlang-man-root-dir "/usr/lib/erlang/man")
(add-to-list 'exec-path "/usr/lib/erlang/bin")

(defun my-erlang-mode-hook ()
  ;; add Erlang functions to an imenu menu
  (imenu-add-to-menubar "imenu")
  ;; customize keys
  (local-set-key [return] 'newline-and-indent))

(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'slime)
(slime-setup)

(require 'cldoc)
(require 'paredit)

(require 'redshank-loader)

(eval-after-load "redshank-loader"
  '(redshank-setup '(lisp-mode-hook
		     slime-repl-mode-hook) t))

(add-hook 'lisp-mode-hook
	  '(lambda ()
	     (nlinum-mode 1)
	     (local-set-key [delete]  'delete-char)
	     (local-set-key [return] 'newline-and-indent)
	     (paredit-mode)
	     (setq show-trailing-whitespace t)))
;;	     (turn-on-redshank-mode)))

(add-hook 'emacs-lisp-mode-hook
	  '(lambda ()
	     (nlinum-mode 1)
	     (local-set-key [delete]  'delete-char)
	     (local-set-key [return] 'newline-and-indent)))

;; Slime for Lisp

(add-to-list 'load-path "~/elisp/slime")

(autoload 'slime "slime" t)

(eval-after-load "slime"
  '(progn
     (message "-> slime loaded")
     (setq slime-repl-history-size 1000
	   slime-net-coding-system 'utf-8-unix
	   ;; when nil - truncate lines
	   slime-truncate-lines nil
	   inferior-lisp-program "/usr/bin/sbcl"
	   slime-kill-without-query-p t
	   slime-lisp-implementations
	   `((sbcl ("sbcl") :coding-system utf-8-unix)))
     (slime-setup '(slime-fancy slime-asdf slime-tramp))
     (require 'slime-fuzzy)
     (slime-fuzzy-init)
     (slime-mode t)
     (global-set-key (kbd "C-c s") 'slime-indent-and-complete-symbol)))

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

;; Display lisp pitfalls on SLIME startup
(require 'slime-cl-pitfalls)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Perl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'perl-mode 'cperl-mode)

(custom-set-variables
 '(cperl-tab-always-indent t)
 '(cperl-indent-level 4)
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-invalid-face nil)
 '(cperl-auto-newline t)
 '(cperl-indent-parens-as-block t))

(add-hook 'cperl-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-h f") 'cperl-perldoc)
	    (local-set-key [return] 'newline-and-indent)
	    (nlinum-mode 1)
	    (flymake-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'python-mode)

(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

(defun my-python-mode-hook ()
  (local-set-key [return] 'newline-and-indent)
  (local-set-key (kbd "\C-c#") 'comment-region)
  (eldoc-mode 1)
  (nlinum-mode 1))

(add-hook 'python-mode-hook 'my-python-mode-hook)

;;;;;;;;;;;;;;
;; Sh/Bash  ;;

(add-hook 'sh-mode-hook '(lambda () (nlinum-mode 1)))

(provide 'rc-lang)
;;; rc-lang.el ends here
