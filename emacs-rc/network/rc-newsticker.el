;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [10.21:39 Май 22 2009]
;; Modified: [01.05:28 Май 23 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 


;;(load-file "/usr/share/emacs/23.0.92/lisp/gnus/mailcap.el.gz")

(autoload 'newsticker-start "newsticker" "Emacs Newsticker" t)
(autoload 'newsticker-show-news "newsticker" "Emacs Newsticker" t)

(custom-set-variables
 '(newsticker-url-list
   '(("EmacsWiki Recently Change"
      "http://www.emacswiki.org/emacs/index.rss" nil nil nil)
     ("Planet Emacsen"
      "http://emacs.defun.ru/atom.xml" nil nil nil)
     ("Kernel Trap"
      "http://kerneltrap.org/node/feed" nil nil nil))))

(provide 'rc-newsticker)
;;; rc-newsticker.el ends here
