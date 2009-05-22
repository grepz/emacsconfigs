;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-08:31 Июль 19 2008]
;; Modified: [13.59:55 Март 15 2009]
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
 '(ecb-layout-window-sizes (quote
			    (("left10"
			      (0.22857142857142856 . 0.6585365853658537)
			      (0.11428571428571428 . 0.3170731707317073)
			      (0.11428571428571428 . 0.3170731707317073)))))
 '(ecb-prescan-directories-for-emptyness t)
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1)))

(when (and (locate-library "ecb") (locate-library "cedet"))
  (require 'ecb))