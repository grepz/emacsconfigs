;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.42:18 Январь 07 2014]
;; Modified: [18.47:24 Август 24 2014]
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
;; C-x j - dired jump(return from editable file for e.g.
;; M-! run command

(require 'dired)
(require 'dired-x)
;;(require 'dired+)

(setq dired-omit-files
      "^\\.?#\\|^\\.$\\|^INDEX$\\|^_darcs$\\|^CVS$\\|^.git$\\|^RCS$\\|^\\.svn$\\|,v$")

(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-omit-mode 1)))

(setq dired-use-ls-dired t
      dired-shell-command-history t)

(put 'dired-find-alternate-file 'disabled nil)

(define-key dired-mode-map [return] 'dired-find-alternate-file)
(define-key dired-mode-map [(a)] 'dired-advertised-find-file)

;; Open dired buffer, path set to current file directory
(define-key global-map (kbd "C-x j") 'dired-jump)

(autoload 'thumbs "thumbs" "Preview images in a directory." t)

(setq auto-mode-alist (cons '("[^/]\\.dired$" . dired-virtual-mode)
			    auto-mode-alist))
