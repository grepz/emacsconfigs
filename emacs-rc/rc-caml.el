;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-13:05 Июль 19 2008]
;; Modified: [16-13:06 Июль 19 2008]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;; Tuareg mode
(add-to-list 'load-path "~/elisp/tuareg-mode")
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu" 
  "Configuration of imenu for tuareg" t) 

(load "~/elisp/tuareg-mode/custom-tuareg.el")

(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(add-hook 'tuareg-mode-hook
	  '(lambda ()
	     (local-set-key [return] 'newline-and-indent)
	     (local-set-key (kbd "C-x c")
			    '(lambda ()
			       (interactive)
			       (insert "(* *)")))
	     (linum-mode 1)
	     (setq tuareg-lazy-= t)
	     (setq tuareg-lazy-paren t)
	     (setq tuareg-in-indent 0) ; no indentation after `in' keywords
             (setq tuareg-font-lock-governing '("brown" "cyan" nil t t t))))
			       

(setq auto-mode-alist 
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode))
	      auto-mode-alist))
