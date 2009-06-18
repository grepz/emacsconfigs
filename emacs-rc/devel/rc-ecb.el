;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-08:31 Июль 19 2008]
;; Modified: [12.33:50 Июнь 17 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(custom-set-variables
 '(ecb-tip-of-the-day nil)
 '(ecb-compile-window-height 10)
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-layout-name "left10")
 '(ecb-prescan-directories-for-emptyness t)
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1)))

(when (and (locate-library "ecb") (locate-library "cedet"))
  (require 'ecb))
