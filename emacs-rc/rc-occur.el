;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [18.24:34 Сентябрь 08 2008]
;; Modified: [19.18:39 Сентябрь 17 2008]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Occurance in buffers
;; moccur, moccur-grep, moccur-grep-find
(require 'color-moccur)

(setq *moccur-buffer-name-exclusion-list*
      '(".+TAGS.+" "*Completions*" "*Messages*" ".bbdb" "\\.txt$"))

;;C-u M-x dmoccur
(setq dmoccur-list
      '(;;name    directory         mask               option
        ("dir"    default-directory (".*")                  dir)
         ("Lisp" (("~/Projects/lisp/" t)
		  ("~/tmp/lisp"))
	  ("\\.lisp$" "\\.asd$") nil)))

(global-set-key "\C-x\C-o" 'occur-by-moccur)
(define-key dired-mode-map "O" 'dired-do-moccur)
(global-set-key "\C-c\C-x\C-o" 'moccur)

