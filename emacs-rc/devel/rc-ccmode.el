;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-07:35 Июль 19 2008]
;; Modified: [13.49:32 Май 10 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;; C warn, test
(require 'cwarn)

(defconst use-backup-dir t)

(require 'cc-mode)

;; (c-add-style "teststyle"
;;  	     '("stroustrup"
;;  	       (indent-tabs-mode . nil)
;;  	       (c-basic-offset . 4)
;;  	       (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
;;  				   (brace-list-open . 0)
;;  				   (statement-case-open . +)))))

;; (defun my-c++-mode-hook ()
;;   (c-set-style "teststyle")        ; use my-style defined above
;;   (auto-fill-mode)
;;   (c-toggle-auto-hungry-state 1))
;; (define-key c++-mode-map "\C-ct" 'some-function-i-want-to-call)

(setq c-default-style "gnu")

;; ede-customize-project ede-customize-target

(defun my-c-mode-common-hook ()
       (c-set-offset 'member-init-intro '++)
;;       (add-to-list 'font-lock-defaults (list my-c-keywords . font-lock-builtin-face))
;;       (setq tab-width 4)
;;       (setq indent-tabs-mode t)
;;       (c-set-offset 'substatement-open 0)
;;       (setq c-basic-offset 4)
       ;; Lets see all ugliness
       (setq show-trailing-whitespace t)
       (setq indent-tabs-mode t)
       (linum-mode 1)
       (c-toggle-auto-hungry-state 1)
       (abbrev-mode 1)
       (auto-fill-mode 1)
       (cwarn-mode 1)
;;       (gtags-mode 1)
       (local-set-key [delete] 'delete-char)
       (local-set-key [return] 'newline-and-indent)
       (local-set-key (kbd "s-g") 'gdb-restore-windows)
       (local-set-key "\C-hf" 'woman)
       (local-set-key "\C-c:" 'uncomment-region)
       (local-set-key "\C-c;" 'comment-region)
       (local-set-key (kbd "C-c <right>") 'hs-show-block)
       (local-set-key (kbd "C-c <left>")  'hs-hide-block)
       (local-set-key (kbd "C-c <up>")    'hs-hide-all)
       (local-set-key (kbd "C-c <down>")  'hs-show-all)
       (hs-minor-mode 1))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(setq user-mail-address "stas@concat.info")
(setq user-full-name "Stanislav M. Ivankin")
;;; Always end a file with a newline
(setq require-final-newline t)

(setq auto-mode-alist (cons '("\\.h\\'" . c++-mode) auto-mode-alist))

(defun user-save-and-make-all ()
  "save and call compile as make all"
  (interactive)
  (save-buffer)
  (compile "make all")
  (message "make all executed!"))

(defun user-make-clean ()
  "save and clean build"
  (interactive)
  (compile "make clean")
  (message "make clean executed!"))

(global-set-key (kbd "\C-cn") 'user-make-clean)
(global-set-key (kbd "\C-cm") 'user-save-and-make-all)
