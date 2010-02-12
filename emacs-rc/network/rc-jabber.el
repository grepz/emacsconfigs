;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [12-38:12 Июль 20 2008]
;; Modified: [23.19:15 Январь 13 2010]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(add-to-list 'load-path "~/elisp/emacs-jabber")

(require 'jabber)
(require 'jabber-autoaway)

;;(require 'autosmiley)
;;(add-hook 'jabber-chat-mode-hook #'(lambda ()
;;				     (setq fill-column 72)
;;				     (turn-on-auto-fill)))
;;				     (autosmiley-mode)



(add-hook 'jabber-post-connect-hook 'jabber-autoaway-start)
;;(setq jabber-nickname "stas"
;;      jabber-server "concat.info"
;;      jabber-resource "notebook")

(custom-set-variables
   '(jabber-history-enabled t)
   '(jabber-use-global-history nil)
   '(jabber-history-dir "~/emacs/tmp/.emacs-jabber")
   '(jabber-backlog-days 60)
   '(jabber-backlog-number 200)
   '(jabber-history-enable-rotation t)
   '(jabber-history-size-limit 2048)
   '(jabber-xosd-display-time 5)
   '(jabber-vcard-avatars-retrieve nil)
   '(jabber-connection-ssl-program 'gnutls)
   '(starttls-extra-arguments '("--insecure"))
   '(jabber-lost-connection-hook 'my-connect-jabber)
   '(jabber-username "stas")
   '(jabber-server "concat.info"))
 
(jabber-mode-line-mode)

;;(add-to-list 'jabber-alert-message-hooks
;;	     'jabber-message-xosd)

(defun jabber-xosd-display-message (message)
  "Displays MESSAGE through the xosd"
  (let ((process-connection-type nil))
    (start-process "jabber-xosd" nil "osd_cat"
		   "-p" "bottom"
		   "-c" "green"
		   "-A" "right"
		   "-f" "-cronyx-helvetica-bold-r-normal--34-240-100-100-p-130-koi8-r"
		   "-d" (number-to-string jabber-xosd-display-time))
    (process-send-string "jabber-xosd" message)
    (process-send-eof "jabber-xosd")))

(defun jabber-message-xosd (from buffer text propsed-alert)
  (jabber-xosd-display-message "[emacs-jabber] New message."))

(global-set-key (kbd "s-j") 'jabber-connect-all)

(defun stumpwm-notify (from buffer text prop-alert)
  (start-process "stumpwm-notify"
		 nil "stumpish" "echo" (concat "[jabber] " from)))

(add-to-list 'jabber-alert-message-hooks
	     'jabber-message-xosd)
