;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [21-00:48 Март 13 2008]
;; Modified: [19.33:26 Сентябрь 17 2008]
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;;;;;;;;;;;;;;;;;;;;;;
;; Storing tmpfiles ;;

(defvar tmp-autosave-dir "~/emacs/tmp/autosave/")

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat tmp-autosave-dir
	  (if buffer-file-name
	      (concat "#" (file-name-nondirectory buffer-file-name) "#")
	    (expand-file-name
	     (concat "#%" (buffer-name) "#")))))

(defvar backup-dir "~/emacs/tmp/backup/")
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Info
(setq Info-fontify "t")

(global-set-key [f9] 'term)
;;(custom-set-variables
;; '(term-default-fg-color "white")
;; '(term-default-bg-color "black"))

(require 'tar-mode)

;; Tex/Latex stuff
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)

;; ispell
(require 'ispell)
(require 'flyspell)

(setq ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra")
      ispell-enable-tex-parser t)

(setq flyspell-default-dictionary "english"
      flyspell-delay '1
      flyspell-issue-message-flag nil)

;; Restructured text, an easy to use and handfull util for editing simple text
(require 'rst)

;; Bookmarks
(require 'bookmark)
(require 'bookmark+)

;; Debian stuff
(autoload 'wajig "wajig"
  "Create a *wajig* buffer." t)

(load-library "~/elisp/apt/apt-mode")

;; Top mode
;;(require 'top-mode)
(load-library "~/elisp/top-mode")

;; crontab
(load-library "~/elisp/crontab-mode")
;;(require 'crontab-mode)
(add-to-list 'auto-mode-alist '("\\.cron\\(tab\\)?\\'" . crontab-mode))
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."    . crontab-mode))

;; Spook with your mail
(require 'spook)

;; Highlight current line
;;(global-hl-line-mode 1)

;; Elscreen
;;(load "elscreen" "ElScreen" t)

;; Command-line menu
(require 'lacarte)
(global-set-key [f10]   'lacarte-execute-menu-command)
