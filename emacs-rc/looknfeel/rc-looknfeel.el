;;; rc-looknfeel.el --- 

;; Copyright (C) 2012  Stanislav M. Ivankin

;; Author: Stanislav M. Ivankin <lessgrep@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

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
;; iswitchbuf
(require 'iswitchb)
(iswitchb-mode 1)
(nconc (list "*compilation" "*semantic" "*Possible Completions" "*Completions"
	     "*Backtrace" "*Messages*") iswitchb-buffer-ignore)
;; buff-menu+
(require 'buff-menu+)

(require 'ibuffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq-default ibuffer-show-empty-filter-groups nil)

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
		      (mode . kconfig-mode)
		      (mode . ld-script-mode)))
	 ("Assembler" (mode . asm-mode))
	 ("Scheme"    (mode . scheme-mode))
	 ("OrgMode"   (mode . org-mode))
	 ("Java"      (or (mode . java-mode)
			  (name . "\\.java$")))
	 ("Python"    (or (mode . python-mode)
			  (name . "^\\*Python\\*$"))))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "Custom")))


(if (eq window-system 'x)
    (progn
      (load-theme 'manoj-dark t)
      (setq x-select-enable-clipboard t)
      (if (and (> emacs-major-version 22))
	  (set-frame-font "consolas 10")
	(set-frame-font "9x15")))
  (progn
    (message "Terminal decorations")
    (load-theme 'tango-dark t)))

(provide 'rc-looknfeel)
;;; rc-looknfeel.el ends here
