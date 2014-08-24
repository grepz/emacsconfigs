;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.38:14 Январь 07 2014]
;; Modified: [23.08:45 Август 24 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: elisp,emacs,cedet,devel
;; License: GPLv3
;;  ---------------------------
;; Description:

(global-ede-mode t)
(semantic-mode t)

(setq semantic-default-submodes
      '(global-semanticdb-minor-mode
	global-semantic-idle-scheduler-mode
	global-semantic-idle-summary-mode
	global-semantic-decoration-mode
	global-semantic-highlight-func-mode
	global-semantic-stickyfunc-mode
	global-semantic-mru-bookmark-mode
	global-semantic-idle-local-symbol-highlight-mode))

;;;;;
