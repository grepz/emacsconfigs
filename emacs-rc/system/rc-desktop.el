;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.41:59 Январь 07 2014]
;; Modified: [18.57:03 Август 24 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: elisp,emacs
;; License: GPLv3
;;  ---------------------------
;; Description:

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
