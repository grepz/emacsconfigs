;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [17-23:32 Июль 19 2008]
;; Modified: [19.15:43 Май 20 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(fset 'yes-or-no-p 'y-or-n-p)

(put 'narrow-to-region 'disabled nil)

(transient-mark-mode 1)
;; Try C-Enter :)
(cua-selection-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode 0)

(setq frame-title-format "esgal@eternal")

(custom-set-variables
 '(display-time-24hr-format t)
 '(display-time-format "[%H:%M %d/%m]")
 '(line-number-mode t)
 '(column-number-mode t)
 '(display-battery-mode t)
 '(display-time-mode t)
 '(size-indication-mode t)
 '(display-time-load-average t)
 '(display-time-day-and-date t)
 '(timeclock-modeline-display t)
 '(inhibit-startup-message t))

;; Change  mouse scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5) ((control))))

;; show/hide menu-bar
(global-set-key (kbd "C-c o") 'menu-bar-mode)

;; Imenu
(require 'imenu)

;; iswitchbuf
(require 'iswitchb)
(iswitchb-mode 1)
(add-to-list 'iswitchb-buffer-ignore "*Messages*")
(add-to-list 'iswitchb-buffer-ignore "*Backtrace")
(add-to-list 'iswitchb-buffer-ignore "*Completions")
(add-to-list 'iswitchb-buffer-ignore "*Possible Completions")
(add-to-list 'iswitchb-buffer-ignore "*semantic")
(add-to-list 'iswitchb-buffer-ignore "*compilation")

;; buff-menu+
(require 'buff-menu+)
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; Stripes are horizontal lines with different color
(require 'stripes)

;; WithOut man
(setq woman-use-own-frame nil)

;; sr-speedbars
(require 'sr-speedbar)
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

(global-set-key (kbd "s-c o") 'other-frame)

;;(when (eq window-system 'x)
;;  (shell-command "xmodmap -e 'clear Lock' -e 'keycode 66 = F15'")
;;  (global-set-key [F13] 'toggle-input-method))
