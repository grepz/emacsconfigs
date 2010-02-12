;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [17-23:32 Июль 19 2008]
;; Modified: [22.04:25 Октябрь 31 2009]
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

(when (> emacs-major-version 22)
  (global-set-key (kbd "<C-right>") 'forward-symbol)
  (global-set-key (kbd "<C-left>") '(lambda () (interactive)
				      (forward-symbol -1))))

(defun th-display-buffer (buffer force-other-window)
  "If BUFFER is visible, select it.

If it's not visible and there's only one window, split the
current window and select BUFFER in the new window. If the
current window (before the split) is more than 165 columns wide,
split horizontally, else split vertically.

If the current buffer contains more than one window, select
BUFFER in the least recently used window.

This function returns the window which holds BUFFER.

FORCE-OTHER-WINDOW is ignored."
  (or (get-buffer-window buffer)
      (if (one-window-p)
          (let ((new-win (split-window-vertically)))
            (set-window-buffer new-win buffer)
            new-win)
        (let ((new-win (get-lru-window)))
          (set-window-buffer new-win buffer)
          new-win))))

(setq display-buffer-function 'th-display-buffer)
