;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-03:31 Июль 19 2008]
;; Modified: [21.39:47 Июль 31 2013]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;;;;;;;;;;;;;
;; Desktop ;;

(require 'desktop)

(desktop-save-mode 1)

(mapc
 (lambda (symbol) 
   (add-to-list 'desktop-globals-to-save symbol))
 '((buffer-name-history      . 100)
   (dired-regexp-history     . 20)
   (extended-command-history . 100)
   (file-name-history        . 500)
   (grep-history             . 50)
   (minibuffer-history       . 100)
   (query-replace-history    . 60)
   (read-expression-history  . 60)
   (regexp-history           . 60)
   (regexp-search-ring       . 20)
   (search-ring              . 20)
   (shell-command-history    . 50)))

(add-to-list 'desktop-locals-to-save 'buffer-file-coding-system)
(add-to-list 'desktop-locals-to-save 'tab-width)

(setq desktop-dirname "~/emacs/tmp/desktop")

(setq-default desktop-missing-file-warning nil)
(setq-default desktop-path (quote ("~")))
(setq-default desktop-save t)
(setq-default desktop-save-mode t)
(setq-default save-place t)

;;(add-to-list 'load-path "~/elisp/emacs-nav/")
;;(require 'nav)
