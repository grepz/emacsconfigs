;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-14:14 Июль 19 2008]
;; Modified: [01.44:43 Май 23 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(load "~/elisp/haskell-mode/haskell-site-file")

(custom-set-variables
 '(haskell-program-name "ghci -i")
 '(haskell-font-lock-symbols t))

(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hi$"     . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))

(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

(autoload 'haskell-mode "haskell-mode"
  "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
  "Major mode for editing literate Haskell scripts." t)

(add-hook 'haskell-mode-hook 'turn-on-haskell-font-lock)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook
	  '(lambda ()
	     (linum-mode 1)
	     (local-set-key (kbd "C-h f") 'haskell-hoogle)
	     (local-set-key [return] 'newline-and-indent)))
