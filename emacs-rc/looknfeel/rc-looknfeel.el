;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.34:49 Январь 07 2014]
;; Modified: [18.28:09 Август 24 2014]
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

(setq split-width-threshold nil
      split-window-preferred-function 'split-window-sensibly)

;; Change  mouse scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5) ((control))))

;; show/hide menu-bar
(global-set-key (kbd "C-c o") 'menu-bar-mode)

;; Minibufer completion
(require 'icomplete)
(icomplete-mode 1)

(eval-after-load "icomplete"
  '(progn
     (require 'icomplete+)
     ;; C-, ; C-. to cycle.
     ;; C-j to jump to current completion
     (icompletep-cycling-mode)))

;; Convenient buffer menu
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

(defvar fa-syms-codes
  '(:computer     [#xF109]
    :tag          [#xF02C]
    :lines-lalign [#xF036]))
(defmacro fa-sym (key)
  `(plist-get fa-syms-codes ,key))

;; auto-fill
(eval-after-load 'diminish-autoloads
  '(eval-after-load 'simple
     '(diminish 'auto-fill-function (concat " " (fa-sym :lines-lalign)))))
;; gtags
(add-hook 'ggtags-mode-hook
	  '(lambda ()
	     (diminish 'ggtags-mode (concat " " (fa-sym :tag)))))
;; slime
(add-hook 'slime-mode-hook
	  '(lambda ()
	     (diminish 'slime-mode (concat " " (fa-sym :computer)))))

;; Text scale
(global-set-key (kbd "s-+") 'text-scale-increase)
(global-set-key (kbd "s--") 'text-scale-decrease)

;; Powerline
(require 'powerline)
(custom-set-faces
 '(mode-line
   ((t (:foreground "#f9f9f9" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive
   ((t (:foreground "#898989" :background "#666666" :box nil)))))
(powerline-default-theme)

;; When 2 buffers(files) has the same names code below will mark both buffers
;; with directory specification
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward uniquify-separator "@")

(provide 'rc-looknfeel)
;;; rc-looknfeel.el ends here
