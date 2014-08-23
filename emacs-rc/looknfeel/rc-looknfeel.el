;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.34:49 Январь 07 2014]
;; Modified: [09.02:17 August 23 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: elisp,emacs,font
;; License: GPLv3
;;  ---------------------------
;; Description:

(fset 'yes-or-no-p 'y-or-n-p)
(put 'narrow-to-region 'disabled nil)
(transient-mark-mode 1)
(cua-selection-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode 0)

(setq frame-title-format "grepz@eternal")

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
 '(inhibit-startup-message t)
 '(font-lock-maximum-decoration nil))

;; Change  mouse scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5) ((control))))

;; show/hide menu-bar
(global-set-key (kbd "C-c o") 'menu-bar-mode)

(setq split-width-threshold nil
      split-window-preferred-function 'split-window-sensibly)

(when (> emacs-major-version 22)
  (global-set-key (kbd "<C-right>") 'forward-symbol)
  (global-set-key (kbd "<C-left>") '(lambda () (interactive)
				      (forward-symbol -1))))

;; Imenu
(require 'imenu)

(require 'icomplete)
(icomplete-mode 99)

;; They say that iswitch is obsolete, but thats lies
(require 'iswitchb)
(iswitchb-mode 1)

;; buff-menu+
;;(require 'buff-menu+)

(require 'ibuffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq-default ibuffer-show-empty-filter-groups nil)

;; Why it hasnt been defvar'ed in ibuffer???
(defvar ibuffer-saved-filter-groups)

(setq ibuffer-saved-filter-groups
      '(("Custom"
	 ("Dired" (mode . dired-mode))
	 ("Perl" (mode . cperl-mode))
	 ("Erc" (mode . erc-mode))
	 ("Elisp" (or (mode .emacs-lisp-mode)
		      (name . "\\.el$")))
	 ("Lisp" (or (mode . sbcl-mode)
		     (mode . lisp-mode)))
	 ("Help" (or (name . "\*Help\*")
		     (mode . help-mode)
		     (name . "\*Apropos\*")
		     (name . "\*info\*")))
	 ("w3m" (mode . w3m-mode))
	 ("c/cpp" (or (mode . c-mode)
		      (mode . c++-mode)
		      (name . "\\.\(c|cpp|cxx\)$")
		      (name . "\\.(h|hpp)$")))
	 ("Erlang" (or (mode . erlang-mode)
		       (name . "\\.erl$")))
	 ("Additional" (or
			(name . "^\\*scratch\\*$")
			(name . "^\\*Messages\\*$")
			(name . "^\\*compilation")
			(name . "^\\*semantic")))
	 ("Build" (or (mode . cmake-mode)
		      (mode . makefile-mode)
		      (mode . makefile-gmake-mode)
;;		      (mode . kconfig-mode)
		      (mode . ld-script-mode)))
	 ("Assembler" (mode . asm-mode))
	 ("Scheme"    (mode . scheme-mode))
	 ("OrgMode"   (mode . org-mode))
	 ("Java"      (or (mode . java-mode)
			  (name . "\\.java$")))
	 ("Python"    (or (mode . python-mode)
			  (name . "^\\*Python\\*$")))
	 ("Verilog"   (or (mode . verilog-mode)
			  (name . "\\.v$"))))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "Custom")))

(if (eq window-system 'x)
    (progn
      (load-theme 'manoj-dark t)
      (setq x-select-enable-clipboard t)
      (if (and (> emacs-major-version 22))
	  (set-frame-font "consolas 13")
	(set-frame-font "9x15")))
  (progn
    (message "Terminal decorations")
    (load-theme 'tango-dark t)))

;; Modeline

;;;; Font-Awesome hacks(http://fortawesome.github.io/Font-Awesome)

;; auto-fill
(eval-after-load 'diminish-autoloads
  '(eval-after-load 'simple
     '(diminish 'auto-fill-function (concat " " [#xF036]))))

;; gtags
(add-hook 'ggtags-mode-hook
	  '(lambda ()
	     (diminish 'ggtags-mode (concat " " [#xF02C]))))

;; slime
(add-hook 'slime-mode-hook
	  '(lambda ()
	     (diminish 'slime-mode (concat " " [#xF109]))))

;; Text scale
(global-set-key (kbd "s-+") 'text-scale-increase)
(global-set-key (kbd "s--") 'text-scale-decrease)

;; Powerline

(require 'powerline)
(custom-set-faces
 '(mode-line
   ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive
   ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))
(powerline-default-theme)

(provide 'rc-looknfeel)
;;; rc-looknfeel.el ends here
