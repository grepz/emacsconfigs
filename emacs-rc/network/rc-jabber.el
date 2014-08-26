;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.49:20 Январь 31 2014]
;; Modified: [01.03:54 Август 26 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: jabber,emacs,elisp
;; License: GPLv3
;;  ---------------------------
;; Description:

;; Code:

(require 'jabber)
(require 'jabber-autoaway)

(add-hook 'jabber-post-connect-hook 'jabber-autoaway-start)

(custom-set-variables
   '(jabber-history-enabled t)
   '(jabber-use-global-history nil)
   '(jabber-history-dir "~/emacs/tmp/.emacs-jabber")
   '(jabber-backlog-days 60)
   '(jabber-backlog-number 200)
   '(jabber-history-enable-rotation t)
   '(jabber-history-size-limit 16384)
   '(jabber-xosd-display-time 5)
   '(jabber-vcard-avatars-retrieve nil)
   '(jabber-connection-ssl-program 'gnutls)
   '(starttls-extra-arguments '("--insecure"))
;;   '(jabber-lost-connection-hook 'my-connect-jabber)
   )

(setq jabber-account-list `((,jabber-eterhost-user
			     (:password . ,jabber-eterhost-password)
			     (:network-server . "eterhost.org")
			     (:port . 5222))
			    (,jabber-saptech-user
			     (:password . ,jabber-saptech-password)
			     (:network-server . "server.rpk-idea.ru")
;;			     (:connection-type . ssl)
			     (:port . 5222))
			    (,jabber-dukgo-user
			     (:password . ,jabber-dukgo-password)
			     (:network-server . "dukgo.com")
			     (:port . 5222))))

(jabber-mode-line-mode)

(global-set-key (kbd "s-j") 'jabber-connect-all)
