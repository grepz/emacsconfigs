;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [18.24:34 Сентябрь 08 2008]
;; Modified: [18.10:36 Январь 06 2014]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(require 'color-moccur)

(setq *moccur-buffer-name-exclusion-list*
      '(".+TAGS.+" "*Completions*" "*Messages*" ".bbdb" "\\.txt$"))

(global-set-key "\C-c\C-s" 'moccur)
(global-set-key "\C-c\C-d" 'moccur-grep-find)
