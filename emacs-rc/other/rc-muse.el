;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.41:11 Январь 07 2014]
;; Modified: [17.59:25 Февраль 23 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: elisp,emacs,muse,web
;; License: GPLv3
;;  ---------------------------
;; Description:

(eval-when-compile (require 'cl))

(require 'muse)
(require 'muse-mode)
(require 'muse-publish)
(require 'muse-html)
(require 'muse-project)
(require 'muse-colors)
(require 'muse-wiki)

(setq muse-html-src-allowed-modes t)

(muse-derive-style
 "eterhost-xhtml" "xhtml"
 :header "~/Projects/web/eterhost.org/muse/header.tmpl"
 :footer "~/Projects/web/eterhost.org/muse/footer.tmpl"
 :date-format 'muse-blog-html-date-format
 :entry-template 'muse-blog-html-entry-template
 :before-end 'muse-blog-html-munge-buffer)

;;(require 'thumb-page)
