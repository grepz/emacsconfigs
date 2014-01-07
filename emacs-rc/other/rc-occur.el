;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.41:33 Январь 07 2014]
;; Modified: [14.41:34 Январь 07 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: elisp,emacs,search,devel
;; License: GPLv3
;;  ---------------------------
;; Description:

(require 'color-moccur)

(setq *moccur-buffer-name-exclusion-list*
      '(".+TAGS.+" "*Completions*" "*Messages*" ".bbdb" "\\.txt$"))

(global-set-key "\C-c\C-s" 'moccur)
(global-set-key "\C-c\C-d" 'moccur-grep-find)
