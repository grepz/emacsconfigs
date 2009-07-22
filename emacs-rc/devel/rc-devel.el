;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [18-51:53 Февраль 25 2008]
;; Modified: [14.18:01 Июль 22 2009]
;; Description: Development routines
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: elisp, emacs, devel

(eval-when-compile (require 'cl))

(custom-set-variables 
 '(compilation-scroll-output 1)
 '(compilation-window-height 20)
 '(fill-column 78)
 '(cscope-do-not-update-database t)
 '(flymake-no-changes-timeout 3)
 '(flymake-start-syntax-check-on-newline nil)
 '(flymake-start-syntax-check-on-find-file nil)
 '(gdb-many-windows t)
 ;; starts with two windows: one displaying the GUD buffer,
 ;; and the other showing the source for the
 ;; `main'
 ;;(setq gdb-show-main t)
 '(gdb-use-separate-io-buffer nil)
 '(show-paren-style 'parenthesis))

;; Set execution bits to script files, idea was taken on emacswiki.org
(add-hook
 'after-save-hook
 #'(lambda ()
     (save-r/e/md
      (widen)
      (goto-char (point-min))
      (when (looking-at "^#!")
	(change-execution-bit)))))

;; Timeclock thingy
;;(require 'timeclock)
;;(global-set-key (kbd "s-i") 'timeclock-in)
;;(global-set-key (kbd "s-o") 'timeclock-out)

;; Line numbers
(require 'linum)

;; Emacs tags
(require 'etags)

;;;;;;;;;;;;;;;;
;; Yasnippet ;;

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "/home/esgal/elisp/yasnippet/snippets/text-mode/")

;; $0 defines where the cursor will be left after the expansion
(yas/define 'cc-mode "/*" "/* $0 */")
(yas/define 'cc-mode "/**" "/**\n * $0\n **/")

;; GTK/GLib snippets

;; TODO: Make automatic creator of GTK objects

(defun CapitalizeGtkName (name)
  (reduce #'concat (mapcar #'capitalize (split-string name "_"))))

(yas/define 'cc-mode "GTK_OBJ"
	    "#define GTK_${1:OBJ}(obj)\t\\
\t(G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_$1, Gtk${1:$(CapitalizeGtkName text)}))\n")

(yas/define 'cc-mode "GTK_CLASS"
	    "#define GTK_${1:CLASS}_CLASS(klass)\t\\
\t(G_TYPE_CHECK_CLASS_CAST(klass, GTK_TYPE_$1, Gtk${1:$(CapitalizeGtkName text)}Class))")

(yas/define 'cc-mode "GTK_IS_OBJ"
	    "#define GTK_IS_${1:OBJ}(obj)\t\\
\t(G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_$1))")

(yas/define 'cc-mode "GTK_IS_CLASS"
	    "#define GTK_IS_${1:CLASS}_CLASS(klass)\t\\	  \
\t(G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_$1))")

(yas/define 'cc-mode "GTK_GET_CLASS"
	    "#define GTK_${1:CLASS}_GET_CLASS(obj)\t\\
\t(G_TYPE_GET_CLASS((obj), GTK_TYPE_$1, Gtk${1:$(CapitalizeGtkName text)}Class))")

(autoload 'gtk-lookup-symbol "gtk-look" nil t)
(define-key global-map [?\C-h ?\C-j] 'gtk-lookup-symbol)

;;;;;;;;;;;;;;
;; Sh/Bash  ;;

(add-hook 'sh-mode-hook '(lambda ()
			   (linum-mode 1)))

;;;;;;;;;;;;;
;; Doxygen ;;

(require 'tempo)
(require 'doxymacs)

(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (doxymacs-mode t)
	     (doxymacs-font-lock)))

(setq doxymacs-doxygen-dirs
      '(("^/home/esgal/Projects/CPP/blink"
	 "~/Projects/CPP/blink/doc/blink.xml"
	 "file:///home/esgal/Projects/CPP/blink/doc/")))

;; cscope
(require 'xcscope)
;;(require 'xcscope+)

(define-key global-map [(control f3)]  'cscope-set-initial-directory)
(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
(define-key global-map [(control f5)]  'cscope-find-this-symbol)
(define-key global-map [(control f6)]  'cscope-find-global-definition)
(define-key global-map [(control f7)]
  'cscope-find-global-definition-no-prompting)
(define-key global-map [(control f8)]  'cscope-pop-mark)
(define-key global-map [(control f9)]  'cscope-next-symbol)
(define-key global-map [(control f10)] 'cscope-next-file)
(define-key global-map [(control f11)] 'cscope-prev-symbol)
(define-key global-map [(control f12)] 'cscope-prev-file)
(define-key global-map [(meta f9)]  'cscope-display-buffer)
(define-key global-map [(meta f10)] 'cscope-display-buffer-toggle)

;; GNU Global related

;;(autoload 'gtags-mode "gtags" "" t)

;;(require 'xgtags)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Revision control systems ;;

(require 'vc)
(require 'vc-git)

(require 'darcsum)

(require 'vc-git)
(when (featurep 'vc-git)
  (add-to-list 'vc-handled-backends 'git))

(require 'git)
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

(require 'gitsum)

(require 'magit)
(autoload 'magit-status "magit" nil t)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fontlocking keywords ;;

;; Make special keywords colorfull, just like in vim.
;; TODO: Create more usable interface

(eval-and-compile
  (defvar warn-keywords   '("FIXME" "WARN" "ERR" "BUG"))
  (defvar notice-keywords '("TODO" "XXX" "NOTE")))

(make-my-face 'my-warn-face "red" "white" t)
(make-my-face 'my-notice-face "yellow" "black" t)

(dolist (mode '(c-mode c++-mode cperl-mode sh-mode
		slime-mode emacs-lisp-mode lisp-mode
		tuareg-mode haskell-mode python-mode))
  (add-fontlocked-keywords mode warn-keywords 'my-warn-face)
  (add-fontlocked-keywords mode notice-keywords 'my-notice-face))

;;;;;;;;;;;;;;;
;; Changelog ;;

;; Embedded changelog
(autoload 'embedded-changelog-add-entry
  "~/elisp/embeddedchangelog" nil t)

;;;;;;;;;;;;;;;;
;; Xrefactory ;;

;; (defvar xref-current-project nil)
;; (defvar xref-key-binding 'global)
;; (setq load-path (cons "/home/esgal/emacs/etc/xref/emacs" load-path))
;; (setq exec-path (cons "/home/esgal/emacs/etc/xref" exec-path))
;; (load "xrefactory")
;; (message "xrefactory loaded")

;;;;;;;;;;;;
;; Debian ;;

(require 'wdiff)
(require 'dpatch)

;; Tasks
;;(require 'taskjuggler-mode)

;; ;; Folding
;; (require 'fold-dwim)
;; (require 'folding)
;; (hs-minor-mode t)
;; (outline-minor-mode t)
;; (folding-mode t)
;; (global-set-key (kbd "<f7>")      'fold-dwim-toggle)
;; (global-set-key (kbd "<M-f7>")    'fold-dwim-hide-all)
;; (global-set-key (kbd "<S-M-f7>")  'fold-dwim-show-all)

;;;;;;;;;;;;;
;; Flymake ;;

(require 'flymake)

(global-set-key (kbd "C-c <f3>") 'flymake-display-err-menu-for-current-line)
(global-set-key (kbd "C-c <f4>") 'flymake-goto-next-error)

;; C/C++ flymake example:
;;check-syntax:
;;	gcc -o nul -Wall -S $(CHK_SOURCES)
;;

;; check-syntax: $(objects:.o=.c)
;; 	$(CC) $(CFLAGS) -fsyntax-only $(CHK_SOURCES)


;;(add-hook 'find-file-hook 'flymake-find-file-hook)

;;;;;;;;;;;
;;

(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt$" . cmake-mode))

;;(autoload 'todoo "todoo" "TODO Mode" t)
;;(add-to-list 'auto-mode-alist '("TODO$" . todoo-mode))

;;;;;;;;;;;;;;;;;;
;; Hideshow
(require 'hideshow)

;;;;;;;;;;;;;;;;;;;;;;;;;
;; 80 characters long
(require 'highlight-80+)

(dolist (hook '(python-mode-hook
		emacs-lisp-mode-hook
		c-mode-common-hook 
	        tuareg-mode-hook))
  (add-hook hook 'highlight-80+-mode))

;;;;;;;;;;;;;;;;;;;;;;
;; Paren

(show-paren-mode 1)

(set-face-background 'show-paren-match-face "#BBBBBB")
(set-face-attribute 'show-paren-match-face nil 
		    :weight 'bold :underline nil :overline nil
		    :slant 'normal)
(set-face-foreground 'show-paren-mismatch-face "red")
(set-face-attribute 'show-paren-mismatch-face nil 
                    :weight 'bold :underline nil :overline nil
		    :slant 'normal)

(require 'pretty-lambdada)
(pretty-lambda-for-modes)
(pretty-lambda 'emacs-lisp-mode)
(pretty-lambda 'tuareg-mode)
