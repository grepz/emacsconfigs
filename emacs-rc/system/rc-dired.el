;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [22-55:36 Июль 19 2008]
;; Modified: [16-32:06 Июль 20 2008]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;;;; Notes:
;; 1. wdired-change-to-wdired-mode, then rename files, simple and fast.
;; Oh, and if to use keyboard macroses {C-x ( ; C-x )}, it is really great! :)
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

(autoload 'thumbs "thumbs" "Preview images in a directory." t)

(setq auto-mode-alist (cons '("[^/]\\.dired$" . dired-virtual-mode)
			    auto-mode-alist))
