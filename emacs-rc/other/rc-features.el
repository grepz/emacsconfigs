;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [21-00:48 Март 13 2008]
;; Modified: [21.45:18 Июль 31 2013]
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(custom-set-variables
 '(mc-gpg-user-id "Stanislav M. Ivankin")
 '(Info-fontify "t")
 '(ispell-program-name "aspell")
 '(ispell-extra-args '("--sug-mode=ultra"))
 '(ispell-enable-tex-parser t)
 '(flyspell-default-dictionary "english")
 '(flyspell-delay '1)
 '(flyspell-issue-message-flag nil)
 '(undo-limit 500000))

;;;;;;;;;;;;;;;;;;;;;;
;; Storing tmpfiles ;;

(defvar tmp-autosave-dir "~/emacs/tmp/autosave/")
(defvar backup-dir "~/emacs/tmp/backup/")

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat tmp-autosave-dir
	  (if buffer-file-name
	      (concat "#" (file-name-nondirectory buffer-file-name) "#")
	    (expand-file-name
	     (concat "#%" (buffer-name) "#")))))

(setq backup-directory-alist (list (cons "." backup-dir)))

(global-set-key [f9] 'term)

(require 'tar-mode)

;; Tex/Latex stuff
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)

;; ispell
(require 'ispell)
(require 'flyspell)

;; Restructured text, an easy to use and handfull util for editing simple text
(require 'rst)

;; Command-line menu
;;(require 'lacarte)
;;(global-set-key [f10]   'lacarte-execute-menu-command)

;; Somewhat more advanced fill paragraph mode for emacs
(require 'filladapt)
(setq-default filladapt-mode t)
