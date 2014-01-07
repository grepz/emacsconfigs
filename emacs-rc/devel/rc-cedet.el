;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.38:14 Январь 07 2014]
;; Modified: [14.38:15 Январь 07 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: elisp,emacs,cedet,devel
;; License: GPLv3
;;  ---------------------------
;; Description:

(global-ede-mode t)
(semantic-mode t)

(global-semantic-idle-completions-mode)

(setq semantic-default-submodes
      '(global-semanticdb-minor-mode
	global-semantic-idle-scheduler-mode
	global-semantic-idle-summary-mode
	global-semantic-idle-completions-mode
	global-semantic-decoration-mode
	global-semantic-highlight-func-mode
	global-semantic-stickyfunc-mode
	global-semantic-mru-bookmark-mode
	global-semantic-idle-local-symbol-highlight-mode))

(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
(semanticdb-enable-gnu-global-databases 'python-mode)

(semantic-gcc-setup)

;;;;;
