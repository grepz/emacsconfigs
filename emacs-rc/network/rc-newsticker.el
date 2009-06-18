;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [10.21:39 Май 22 2009]
;; Modified: [16.44:14 Июнь 17 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(load-file "/usr/share/emacs/23.0.93/lisp/gnus/mailcap.el.gz")

(autoload 'w3m-region "w3m"
  "Render region in current buffer and replace with result." t)

(autoload 'newsticker-start "newsticker" "Emacs Newsticker" t)
(autoload 'newsticker-show-news "newsticker" "Emacs Newsticker" t)

(custom-set-variables
 '(newsticker-retrieval-interval -1)
 '(newsticker-html-renderer 'w3m-region)
 '(newsticker-frontend 'newsticker-treeview)
 '(newsticker-keep-obsolete-items t)
 '(newsticker-cache-filename "~/emacs/tmp/newsticker/newsticker.cache")
 '(newsticker-dir "~/emacs/tmp/newsticker/")
 ;; Feeds as they are
 '(newsticker-url-list
   '(("Russian Planet Emacs"
      "http://emacs.defun.ru/atom.xml" nil nil nil)
     ("Plane Emacs"
      "http://planet.emacsen.org/atom.xml" nil nil nil)
     ("Kernel Trap"
      "http://kerneltrap.org/node/feed" nil nil nil)
     ("Reddit - Technology"
      "http://www.reddit.com/r/technology/.rss" nil nil nil)
     ("Reddit - Science"
      "http://www.reddit.com/r/science/.rss" nil nil nil)
     ("Reddit - Worldnews"
      "http://www.reddit.com/r/worldnews/.rss" nil nil nil)
     ("Reddit - Math"
      "http://www.reddit.com/r/math/.rss" nil nil nil)
     ("Reddit - Programming"
      "http://www.reddit.com/r/programming/.rss" nil nil nil)
     ("OSNews"
      "http://www.osnews.com/files/recent.xml" nil nil nil)
     ("Linux.org.ru"
      "http://www.linux.org.ru/section-rss.jsp?section=1" nil nil nil))))

(provide 'rc-newsticker)
;;; rc-newsticker.el ends here
