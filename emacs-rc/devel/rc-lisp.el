;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-14:49 Июль 19 2008]
;; Modified: [18.51:07 Январь 17 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;;(require 'vnesting)

;;(add-hook 'slime-lisp-mode-hook 'vnest-mode)
;;(add-hook 'lisp-mode-hook 'vnest-mode)

(require 'cldoc)
(require 'paredit)

(require 'redshank-loader)

(eval-after-load "redshank-loader"
  '(redshank-setup '(lisp-mode-hook
		     slime-repl-mode-hook) t))

;;(autoload 'redshank-mode "redshank"
;;  "Minor mode for editing and refactoring (Common) Lisp code."
;;  t)
;;(autoload 'turn-on-redshank-mode "redshank"
;;  "Turn on Redshank mode.  Please see function `redshank-mode'."
;;  t)

(add-to-list 'auto-insert-alist '(lisp-mode . redshank-in-package-skeleton))
(add-to-list 'auto-insert-alist '(asdf-mode . redshank-asdf-defsystem-skeleton))
(add-to-list 'auto-mode-alist '("\\.asdf?\\'" . asdf-mode))

;;;;   (eval-after-load "redshank"
;;;;     '(progn ...redefine keys, etc....))

(add-hook 'lisp-mode-hook
	  '(lambda ()
	     (linum-mode 1)
	     (local-set-key [delete]  'delete-char)
	     (local-set-key [return] 'newline-and-indent)
	     (paredit-mode)
	     (setq show-trailing-whitespace t)))
;;	     (turn-on-redshank-mode)))

(add-hook 'emacs-lisp-mode-hook
	  '(lambda ()
	     (linum-mode 1)
	     (local-set-key [delete]  'delete-char)
	     (local-set-key [return] 'newline-and-indent)))

;; Slime for Lisp

(add-to-list 'load-path "~/elisp/slime")
(add-to-list 'load-path "~/hacking/lisp/slime/")

(global-set-key [f12] 'slime)

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
	   slime-lisp-implementations `((sbcl ("sbcl") :coding-system utf-8-unix)))
     (slime-setup '(slime-fancy slime-asdf slime-tramp))
     (require 'slime-fuzzy)
     (slime-fuzzy-init)
     (slime-mode t)
;;     (paredit-mode) ;ymmv: is great and gets in your way
     (global-set-key (kbd "C-c s") 'slime-indent-and-complete-symbol)))

;; ymmv remove this if you want
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

;; Display lisp pitfalls on SLIME startup
(require 'slime-cl-pitfalls)
