;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-06:15 Июль 19 2008]
;; Modified: [01.23:54 Февраль 09 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 


;;; History:
;; 2008-07-19  Stanislav M. Ivankin  <stas@concat.info>
;; 
;;   * rc-cedet.el: All cedet stuff goes here
;; 

;;; Code:

(add-to-list 'load-path "~/elisp/cedet")
;;(setq semantic-load-turn-everything-on t)
(load-file "~/elisp/cedet/common/cedet.el")

;; (require 'bovine-grammar nil t)
(when (require 'ede nil t)
  (global-ede-mode t))
(require 'semantic nil t)
;; ;(semantic-load-enable-code-helpers)
;; ;(global-semantic-idle-scheduler-mode 1)
;; ;(global-semantic-idle-completions-mode 1)
;; ;(global-semantic-idle-summary-mode 1)
(require 'semantic-sb nil t)
(require 'semanticdb nil t)

(semantic-load-enable-gaudy-code-helpers)

;; smart complitions
(require 'semantic-ia)

(global-semanticdb-minor-mode 1)

(setq-mode-local c-mode semanticdb-find-default-throttle
		 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                  '(project unloaded system recursive))

(require 'eassist)

;; customisation of modes
(defun my-cedet-hook ()
; (local-set-key "\C-c/" 'semantic-ia-complete-symbol)
  (local-set-key "\C-cc" 'semantic-ia-complete-symbol)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-ch" 'eassist-switch-h-cpp))
(add-hook 'c-mode-common-hook 'my-cedet-hook)

(setq-default semanticdb-default-save-directory
	      "~/emacs/tmp/semanticdb/"
	      semanticdb-default-system-save-directory
	      "~/emacs/tmp/semanticdb/")

(semantic-add-system-include "/usr/include" 'c-mode)
(semantic-add-system-include "/usr/include" 'c++-mode)
(semantic-add-system-include "/usr/include/c++/4.2" 'c++-mode)
(semantic-add-system-include "/usr/local/include" 'c-mode)
(semantic-add-system-include "/usr/local/include" 'c++-mode)

(custom-set-variables
 '(semantic-idle-scheduler-idle-time 3))

(global-semantic-stickyfunc-mode -1)

(global-semantic-folding-mode 1)
(global-semantic-tag-folding-mode 1)


;;;;;

(ede-cpp-root-project "JariOS_servers"
                      :name "Jari OS Core servers"
                      :file "/home/esgal/Projects/jarios/core_servers/Makefile"
                      :include-path '("/include")
                      :system-include-path
		      '("~/Projects/jarios/syslibs/general/include"))
