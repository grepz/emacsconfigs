;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-03:16 Июль 19 2008]
;; Modified: [01.22:23 December 27 2010]
;; Description: Color themes and look customization
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;; Customization for frames
(custom-set-variables 
 '(default-frame-alist
    '((vertical-scroll-bars)
      (menu-bar-lines . 1)
      (background-color . "white")
      (foreground-color . "black")
      (background-mode . light)
      (background-toolbar-color . "#cf3ccf3ccf3c")
      (border-color . "#000000000000")
      (bottom-toolbar-shadow-color . "#79e77df779e7")
      (cursor-color . "Red3")
      (mouse-color . "black")
      (top-toolbar-shadow-color . "#fffffbeeffff")
      (viper-saved-cursor-color-in-replace-mode . "Red3")
      (tool-bar-lines . 0))))

(defun color-theme-my-gtk-ide ()
  "Color theme by Gordon Messmer, created 2001-02-07.
Inspired by a GTK IDE whose name I've forgotten.

If you want to modify the font as well, you should customize variable
`color-theme-legal-frame-parameters' to \"\\(color\\|mode\\|font\\|height\\|width\\)$\".
The default setting will prevent color themes from installing specific
fonts."
  ;; The light editor style doesn't seem to look right with
  ;; the same font that works in the dark editor style.
  ;; Dark letters on light background just isn't as visible.
  (interactive)
  (color-theme-install
   '(color-theme-gtk-ide
     ((font . "-monotype-courier new-medium-r-normal-*-*-120-*-*-m-*-iso8859-15")
      (width  . 95)
      (height . 45)
      (background-color . "white")
      (foreground-color . "black")
      (background-mode . light)
      (mouse-color . "grey15")
      (cursor-color . "grey15"))
     (default ((t nil)))
     (font-lock-comment-face ((t (:italic t :foreground "darkgrey"))))
     (font-lock-string-face ((t (:foreground "#883322" :bold t))))
     (font-lock-keyword-face ((t (:foreground "DarkBlue"))))
     (font-lock-warning-face ((t (:bold t :foreground "VioletRed"))))
     (font-lock-constant-face ((t (:foreground "OliveDrab"))))
     (font-lock-type-face ((t (:foreground "SteelBlue4"))))
     (font-lock-variable-name-face ((t (:foreground "Goldenrod"))))
     (font-lock-function-name-face ((t (:foreground "SlateBlue"
					:underline nil
					:bold t
					:italic t))))
     (font-lock-builtin-face ((t (:foreground "ForestGreen"))))
     (highline-face ((t (:background "grey95"))))
     (show-paren-match-face ((t (:background "blue"))))
     (region ((t (:background "grey80"))))
     (highlight ((t (:background "LightSkyBlue"))))
     (secondary-selection ((t (:background "grey55"))))
     (widget-field-face ((t (:background "navy"))))
     (widget-single-line-field-face ((t (:background "royalblue")))))) )

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

(require 'color-theme-subdued)
(require 'color-theme)
(color-theme-initialize)

(if (eq window-system 'x)
    (progn
;;      (color-theme-charcoal-black)
      (color-theme-dark-laptop)
;;      (color-theme-dark-laptop)
;;      (set-my-faces)
;;      (require 'tabbar)
;;      (tabbar-mode t)
      (global-set-key [(s up)]    'tabbar-backward-group)
      (global-set-key [(s down)]  'tabbar-forward-group)
      (global-set-key [(s left)]  'tabbar-backward)
      (global-set-key [(s right)] 'tabbar-forward)
      (setq x-select-enable-clipboard t)
      (if (and (> emacs-major-version 22))
	  (set-frame-font "consolas-12")
	(set-frame-font "9x15")))
  (progn
    (message "Terminal decorations")
    (color-theme-dark-laptop)))
