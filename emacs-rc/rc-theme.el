;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-03:16 Июль 19 2008]
;; Modified: [05.58:41 Декабрь 13 2008]
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
;;	(font . "Bitstream Vera Sans Mono-11")))


;; (defun color-theme-example ()
;;   "Example theme. Carbon copy of color-theme-gnome contributed by Jonadab."
;;   (interactive)
;;   (color-theme-install
;;    '(color-theme-example
;;      ((foreground-color . "wheat")
;;       (background-color . "darkslategrey")
;;       (background-mode . dark))
;;      (default ((t (nil))))
;;      (region ((t (:foreground "cyan" :background "dark cyan"))))
;;      (underline ((t (:foreground "yellow" :underline t))))
;;      (modeline ((t (:foreground "dark cyan" :background "wheat"))))
;;      (modeline-buffer-id ((t (:foreground "dark cyan" :background "wheat"))))
;;      (modeline-mousable ((t (:foreground "dark cyan" :background "wheat"))))
;;      (modeline-mousable-minor-mode ((t (:foreground "dark cyan" :background "wheat"))))
;;      (italic ((t (:foreground "dark red" :italic t))))
;;      (bold-italic ((t (:foreground "dark red" :bold t :italic t))))
;;      (font-lock-comment-face ((t (:foreground "Firebrick"))))
;;      (bold ((t (:bold)))))))

(defun set-my-faces ()
  (custom-set-faces
   '(font-lock-function-name-face ((t (:foreground "MediumSlateBlue" :bold t :underline t))))
   '(font-lock-comment-face ((t (:foreground "#777777" :bold nil :italic t))))
   '(flyspell-incorrect ((t (:underline t :weight normal))))
   '(jabber-roster-user-away ((t (:foreground "green"))))
   '(tabbar-default ((t (:inherit variable-pitch :background "gray82" :foreground "gray50" :height 0.8))))
   '(tabbar-selected ((t (:inherit tabbar-default :background "white" :foreground "blue" :box (:line-width 1 :color "black")))))
   '(tabbar-separator ((t (:inherit tabbar-default :height 0.2))))
   '(tabbar-highlight ((t ())))
   '(tabbar-button-highlight ((t (:inherit tabbar-button))))
   '(tabbar-unselected ((t (:inherit tabbar-default :background "gray72" :foreground "black" :box (:line-width 1 :color "black")))))
   '(buffer-menu-star-buffer ((t (:background "black" :foreground "yellow"))))
   '(buffer-menu-buffer-name ((t (:foreground "green")))))
  (set-face-foreground 'modeline "Black" nil)
  (set-face-foreground 'default "NavajoWhite1" nil))

;;   '(stripes-face ((t (:background "#445588"))))))
;;   '(mode-line ((t (:foreground color1 :background color2 :box (:line-width -1 :style released-button)))))
;;   '(region ((t (:background "gold"))))

(require 'color-theme)
(color-theme-initialize)
(if (eq window-system 'x)
    (progn
;;;;      (color-theme-deep-blue)
;;;;      (color-theme-xemacs)
;;      (color-theme-comidia)
      (color-theme-charcoal-black)
      (set-my-faces)
      (require 'tabbar)
      (tabbar-mode t)
      (global-set-key [(s up)]    'tabbar-backward-group)
      (global-set-key [(s down)]  'tabbar-forward-group)
      (global-set-key [(s left)]  'tabbar-backward)
      (global-set-key [(s right)] 'tabbar-forward)
      (setq x-select-enable-clipboard t)
      (if (and (> emacs-major-version 22) (>= +emacs-build-version+ 60))
	  (progn
	    (set-default-font "Consolas-13")
	    (set-fontset-font "fontset-default" 'cyrillic '("Consolas" . "ISO10646-1")))
;;	    (set-default-font "Inconsolata-14")
;;	    (set-fontset-font "fontset-default" 'cyrillic '("Inconsolata" . "ISO10646-1")))
;;	    (set-default-font "Bitstream Vera Sans Mono-11")
;;	    (set-default-font "Dejavu Sans Mono-11")
;;	    (set-default-font "Monospace-11")
;;	    (set-fontset-font "fontset-default"
	    ;;			      'cyrillic '("Bitstream Vera Sans Mono-11" . "unicode-bmp")))
;;	    (set-fontset-font "fontset-default"
;;			      'cyrillic '("Monospace-11" . "unicode-bmp")))
;;			      'cyrillic '("Dejavu Sans Mono-11" . "unicode-bmp")))	    
	(set-default-font "9x15")))
  (progn
    (message "Terminal decorations")))
;;    (color-theme-tty-dark)))

;;;;
