;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.42:18 Январь 07 2014]
;; Modified: [14.42:19 Январь 07 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: elisp,emacs,dired,search
;; License: GPLv3
;;  ---------------------------
;; Description:

;;;; Notes:
;; wdired-change-to-wdired-mode, then rename files, simple and fast.
;; {C-x ( ; C-x )} macro with dired
;; C-x C-j - dired jump(return from editable file for e.g.
;; M-! run command

(require 'dired)
(require 'dired-x)

(setq dired-omit-files
      "^\\.?#\\|^\\.$\\|^INDEX$\\|^_darcs$\\|^CVS$\\|^RCS$\\|^\\.svn$\\|,v$")

(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-omit-mode 1)))

(setq dired-use-ls-dired t
      dired-shell-command-history t)

(put 'dired-find-alternate-file 'disabled nil)

(define-key dired-mode-map [return] 'dired-find-alternate-file)
(define-key dired-mode-map [(a)] 'dired-advertised-find-file)

(define-key global-map [(control x) (control j)]  'dired-jump)

(autoload 'thumbs "thumbs" "Preview images in a directory." t)

(setq auto-mode-alist (cons '("[^/]\\.dired$" . dired-virtual-mode)
			    auto-mode-alist))
