;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [10.21:39 Май 22 2009]
;; Modified: [17.09:15 Апрель 24 2011]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(autoload 'w3m-region "w3m"
  "Render region in current buffer and replace with result." t)

(autoload 'newsticker-show-news "newsticker" "Emacs Newsticker" t)

(custom-set-variables
 '(newsticker-retrieval-interval -1)
 '(newsticker-html-renderer 'w3m-region)
 '(newsticker-frontend 'newsticker-treeview)
 '(newsticker-keep-obsolete-items t)
 '(newsticker-automatically-mark-items-as-old nil) 
 '(newsticker-automatically-mark-visited-items-as-old t)
 '(newsticker-retrieval-method 'extern)
 '(newsticker-cache-filename "~/emacs/tmp/newsticker/newsticker.cache")
 '(newsticker-dir "~/emacs/tmp/newsticker/")
 '(newsticker-url-list
   '(("Plane Emacs"
      "http://planet.emacsen.org/atom.xml" nil nil nil)
     ("EveNews24"
      "http://feeds.feedburner.com/eveonlinenews24" nil nil nil)
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
      "http://www.osnews.com/files/recent.xml" nil nil nil))))

(provide 'rc-newsticker)
;;; rc-newsticker.el ends here
