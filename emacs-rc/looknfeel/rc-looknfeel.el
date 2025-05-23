;;; rc-looknfeel.el ---
;;
;; Filename: rc-looknfeel.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:10:12 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sat Jan 18 15:58:16 2025 (+0100)
;;           By: Stanislav M. Ivankin
;;     Update #: 212
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


(setq user-mail-address "lessgrep@gmail.com")
(setq user-full-name "Stanislav M. Ivankin")

(fset 'yes-or-no-p 'y-or-n-p)
(put 'narrow-to-region 'disabled nil)
(transient-mark-mode 1)
(cua-selection-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq frame-title-format "grepz@eternal")

(custom-set-variables
 '(tab-width 4)
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
 '(visible-bell nil)
 '(font-lock-maximum-decoration nil))

(setq-default global-visual-line-mode nil)
(setq-default truncate-lines nil)

(setq split-width-threshold nil
      split-window-preferred-function 'split-window-sensibly)

;; Change  mouse scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5) ((control))))

;; show/hide menu-bar
(global-set-key (kbd "C-c o") 'menu-bar-mode)

;; Redefine keys for OS X Aquamacs
(when (eq my-system 'osx)
  (global-set-key [(meta .)] 'hippie-expand)
  (global-set-key [(control right)] 'end-of-line)
  (global-set-key [(control left)] 'beginning-of-line))

;; Minibufer completion
(use-package icomplete
  :ensure
  :config
  (icomplete-mode 1)
  (setq icomplete-minibuffer-map (make-sparse-keymap))
  (define-key icomplete-minibuffer-map (kbd "C-r")
    'icomplete-backward-completions)
  (define-key icomplete-minibuffer-map (kbd "C-s")
    'icomplete-forward-completions))

(require 'icomplete+)
(icompletep-cycling-mode)

;; Convenient buffer menu
(use-package ibuffer
  :ensure
  :config
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  (setq-default ibuffer-show-empty-filter-groups nil)
  (defvar ibuffer-saved-filter-groups
    '(("Custom"
	   ("Dired" (mode . dired-mode))
	   ("Perl"  (mode . cperl-mode))
	   ("Erc"   (mode . erc-mode))
	   ("Elisp" (or (mode .emacs-lisp-mode) (name . "\\.el$")))
	   ("Lisp"  (or (mode . sbcl-mode) (mode . lisp-mode)))
	   ("Help"  (or (name . "\*Help\*") (mode . help-mode)
				    (name . "\*Apropos\*") (name . "\*info\*")))
	   ("w3m"   (mode . w3m-mode))
	   ("c/cpp" (or (mode . c-mode) (mode . c++-mode)
				    (name . "\\.\(c|cpp|cxx\)$")
				    (name . "\\.(h|hpp)$")))
	   ("Erlang"     (or (mode . erlang-mode) (name . "\\.erl$")))
       ("Elixir"     (or (mode . elixir-mode)
                         (name . "\\.ex$")
                         (name . "\\.exs$")))
       ("Rust" (or (mode . rust-mode)
                   (mode . rustic-mode)
                   (name . "\\.rs$")))
	   ("Additional" (or (name . "^\\*scratch\\*$")
					     (name . "^\\*Messages\\*$")
					     (name . "^\\*compilation")
					     (name . "^\\*semantic")))
	   ("Build" (or (mode . cmake-mode) (mode . makefile-mode)
				    (mode . makefile-gmake-mode)
				    (mode . ld-script-mode)))
	   ("Assembler" (mode . asm-mode))
	   ("Scheme"  (mode . scheme-mode))
	   ("OrgMode" (mode . org-mode))
	   ("Java"    (or (mode . java-mode) (name . "\\.java$")))
	   ("Python"  (or (mode . python-mode) (name . "^\\*Python\\*$")))
	   ("Verilog" (or (mode . verilog-mode) (name . "\\.v$"))))))
  (add-hook 'ibuffer-mode-hook
	        (lambda ()
	          (ibuffer-auto-mode 1)
	          (ibuffer-switch-to-saved-filter-groups "Custom"))))

;; (set-frame-font "mono 12")
;; (set-frame-font "input 12")
;; (set-frame-font "consolas 12")
;; (set-frame-font "inconsolata 12")

;;(color-theme-initialize)

(if (boundp 'window-system)
    (progn
	  (message "Graphical decorations")
      (load-theme 'deeper-blue)
      ;;(set-background-color "#011236")
      ;;(set-foreground-color "#eeeeec")
      (setq x-select-enable-clipboard t)
      (if (> emacs-major-version 22)
		  (set-frame-font "FiraCode 18")
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

(use-package diminish :ensure)

;; auto-fill
(eval-after-load 'diminish-autoloads
  '(eval-after-load 'simple
     '(diminish 'auto-fill-function (concat " " (fa-sym :lines-lalign)))))
;; gtags
(add-hook
 'ggtags-mode-hook
 '(lambda () (diminish 'ggtags-mode (concat " " (fa-sym :tag)))))
;; slime
(add-hook
 'slime-mode-hook
 '(lambda () (diminish 'slime-mode (concat " " (fa-sym :computer)))))

;; Text scale
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Use list-colors-display for some inspiration on colors

;; Powerline
(use-package powerline
  :ensure
  :config
  (custom-set-faces
   '(mode-line
     ((t (:foreground "#32cd32" :background "#171717" :box t))))
   '(mode-line-inactive
     ((t (:foreground "#a9a9a9" :background "#333333" :box nil)))))
  (set-face-attribute 'mode-line-buffer-id nil :foreground "#32cd32")
  (powerline-default-theme))

;; When 2 buffers(files) has the same names code below will mark both buffers
;; with directory specification
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward uniquify-separator "@")

;; hl-line
(use-package hl-line
  :ensure
  :config
  (set-face-background hl-line-face "#222345")
  (set-face-foreground font-lock-string-face "#40ff10"))

;; Use regex search by default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

(require 'grep)

(if (executable-find "rg")
    (progn
      (grep-apply-setting 'grep-highlight-matches 'always)
      (grep-apply-setting 'grep-command "rg --null --color always -n -H --no-heading --with-filename -e ")
      (grep-apply-setting
       'grep-find-command
       '("find . -type f -exec rg --null --color always -n -H --no-heading --with-filename -e  \\{\\} +" . 85))))

(use-package which-key
  :ensure
  :config
  (which-key-mode))

(provide 'rc-looknfeel)
;;; rc-looknfeel.el ends here

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-looknfeel.el ends here

