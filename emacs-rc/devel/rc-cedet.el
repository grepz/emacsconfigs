;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-06:15 Июль 19 2008]
;; Modified: [18.11:00 Январь 02 2014]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;;; Code:

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
