;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-13:39 Июль 19 2008]
;; Modified: [19.19:10 Сентябрь 17 2008]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(fset 'perl-mode 'cperl-mode)

(custom-set-variables
 '(cperl-tab-always-indent t)
 '(cperl-indent-level 4)
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-invalid-face nil)
 '(cperl-auto-newline t)
 '(cperl-indent-parens-as-block t))

(custom-set-faces
 '(cperl-array-face ((((class color) (background light))
		      (:background "lightgrey" :foreground "Blue" :weight bold))))
 '(cperl-hash-face ((((class color) (background light))
		     (:background "lightgrey" :foreground "Red" :slant italic :weight bold)))))

(add-hook 'cperl-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-h f") 'cperl-perldoc)
	    (local-set-key [return] 'newline-and-indent)
	    (linum-mode 1)
	    (flymake-mode 1)))
