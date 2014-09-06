;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.38:39 Январь 07 2014]
;; Modified: [14.20:12 Август 31 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: elisp,emacs,devel
;; License: GPLv3
;;  ---------------------------
;; Description:

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
  (setq indent-tabs-mode nil)
  (linum-mode 1)
  (c-toggle-auto-hungry-state 1)
  (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
    (ggtags-mode 1))
  (auto-fill-mode 1)
  (cwarn-mode 1)
  (local-set-key [delete] 'delete-char)
  (local-set-key [return] 'newline-and-indent)
  (local-set-key (kbd "s-g") 'gdb-restore-windows)
  (local-set-key "\C-hf" 'woman)
  (local-unset-key (kbd "C-c C-d")))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Erlang
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'erlang)

(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

(setq-default erlang-root-dir "/usr/lib/erlang")
(setq-default erlang-man-root-dir "/usr/lib/erlang/man")
(add-to-list 'exec-path "/usr/lib/erlang/bin")

(defun my-erlang-mode-hook ()
  (linum-mode 1)
  ;; add Erlang functions to an imenu menu
  (imenu-add-to-menubar "imenu")
  ;; customize keys
  (local-set-key [return] 'newline-and-indent))

(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Turn on paredit mode when required
(autoload 'paredit-mode "paredit" t)

;;(add-to-list 'load-path "/home/grepz/elisp/slime/")

;; Redshank mode
(require 'redshank-loader)
(eval-after-load "redshank-loader"
  '(redshank-setup '(lisp-mode-hook
		     slime-repl-mode-hook) t))

(add-hook 'lisp-mode-hook
	  '(lambda ()
	     (linum-mode 1)
	     (auto-fill-mode 1)
	     (local-set-key [delete]  'delete-char)
	     (local-set-key [return] 'newline-and-indent)
	     (paredit-mode)))

(add-hook 'emacs-lisp-mode-hook
	  '(lambda ()
	     (linum-mode 1)
	     (auto-fill-mode 1)
	     (local-set-key [delete]  'delete-char)
	     (local-set-key [return] 'newline-and-indent)
	     (paredit-mode)))

;; Slime for Lisp

(require 'slime-autoloads)

(setq slime-repl-history-size 1000
	   slime-net-coding-system 'utf-8-unix
	   ;; when nil - truncate lines
	   slime-truncate-lines nil
	   inferior-lisp-program "/usr/bin/sbcl"
	   slime-kill-without-query-p t
	   slime-contribs '(slime-fancy slime-tramp slime-asdf)
	   slime-lisp-implementations `((sbcl ("sbcl")
					      :coding-system utf-8-unix)))

(eval-after-load "slime"
  '(progn
     (require 'slime-fuzzy)
     (slime-fuzzy-init)
     (slime-setup '(slime-fancy slime-asdf slime-tramp))
     (paredit-mode)
     (redshank-mode)
;;     (add-hook 'slime-mode-hook 'set-up-slime-ac)
;;     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
     (slime-mode t)
     (slime-scratch)
     (message "-> slime loaded")))


(defun slime-run ()
  (interactive)
  (slime))

;;(autoload 'slime "slime" t)

;; Display lisp pitfalls on SLIME startup
;;(require 'slime-cl-pitfalls)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Scheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'geiser)

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
	    (linum-mode 1)
	    (local-set-key (kbd "C-h f") 'cperl-perldoc)
	    (local-set-key [return] 'newline-and-indent)
	    (linum-mode 1)
	    (flymake-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'python)

(defun my-python-mode-hook ()
  (local-set-key [return] 'newline-and-indent)
  (linum-mode 1))

(add-hook 'python-mode-hook 'my-python-mode-hook)

;;;;;;;;;;;;;;
;; Sh/Bash  ;;

(add-hook 'sh-mode-hook '(lambda () (linum-mode 1)))

;;;;;;;;;;;;;;
;; Verilog  ;;

(add-hook 'verilog-mode-hook
	  '(lambda ()
	     (linum-mode 1)
	     (setq-default compilation-error-regexp-alist
			   (mapcar 'cdr verilog-error-regexp-emacs-alist))))

;;;;;;;;;;;;;;
;; KConfig  ;;

;;(require 'kconfig-mode)

(provide 'rc-lang)
;;; rc-lang.el ends here
