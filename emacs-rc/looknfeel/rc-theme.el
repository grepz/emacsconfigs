;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-03:16 Июль 19 2008]
;; Modified: [20.10:37 Апрель 16 2009]
;; Description: Color themes and look customization
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;; Customization for frames
(setq default-frame-alist
      '((vertical-scroll-bars)
	(menu-bar-lines . 1)
	(background-color . "white")
	(background-mode . light)
	(background-toolbar-color . "#cf3ccf3ccf3c")
	(border-color . "#000000000000")
	(bottom-toolbar-shadow-color . "#79e77df779e7")
	(cursor-color . "Red3")
	(foreground-color . "black")
	(mouse-color . "black")
	(top-toolbar-shadow-color . "#fffffbeeffff")
	(viper-saved-cursor-color-in-replace-mode . "Red3")
	(tool-bar-lines . 0)))

(defun set-my-faces ()
  (custom-set-faces
   '(font-lock-function-name-face ((t (:foreground "MediumSlateBlue"
				       :bold t
				       :underline t))))
   '(font-lock-comment-face ((t (:foreground "#777777" :bold nil :italic t))))
   '(flyspell-incorrect ((t (:underline t :weight normal))))
   '(jabber-roster-user-away ((t (:foreground "green"))))
   '(tabbar-default ((t (:inherit variable-pitch :background "gray82"
			 :foreground "gray50" :height 0.8))))
   '(tabbar-selected ((t (:inherit tabbar-default :background "white"
			 :foreground "blue"
			 :box (:line-width 1 :color "black")))))
   '(tabbar-separator ((t (:inherit tabbar-default :height 0.2))))
   '(tabbar-highlight ((t ())))
   '(tabbar-button-highlight ((t (:inherit tabbar-button))))
   '(tabbar-unselected ((t (:inherit tabbar-default
			    :background "gray72"
			    :foreground "black"
			    :box (:line-width 1 :color "black")))))
   '(buffer-menu-star-buffer ((t (:background "black" :foreground "yellow"))))
   '(buffer-menu-buffer-name ((t (:foreground "green")))))
  (set-face-foreground 'modeline "Black" nil)
  (set-face-foreground 'default "NavajoWhite1" nil))

(if (eq window-system 'x)
    (progn
      (require 'color-theme)
      (color-theme-initialize)
      (color-theme-charcoal-black)
      (set-my-faces)
;;      (require 'tabbar)
;;      (tabbar-mode t)
      (global-set-key [(s up)]    'tabbar-backward-group)
      (global-set-key [(s down)]  'tabbar-forward-group)
      (global-set-key [(s left)]  'tabbar-backward)
      (global-set-key [(s right)] 'tabbar-forward)
      (setq x-select-enable-clipboard t)
      (if (and (> emacs-major-version 22) (>= +emacs-build-version+ 60))
	  (progn
	    (set-default-font "Consolas-10")
	    (set-fontset-font "fontset-default"
			      'cyrillic '("Consolas" . "ISO10646-1")))
	(set-default-font "9x15")))
  (progn
    (message "Terminal decorations")))
