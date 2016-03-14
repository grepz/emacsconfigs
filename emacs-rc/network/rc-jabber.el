;;; rc-jabber.el ---
;;
;; Filename: rc-jabber.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:09:48 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Fri Aug  7 19:08:37 2015 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 6
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


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
   '(starttls-extra-arguments '("--insecure")))


(setq jabber-debug-log-xml t)
(setq jabber-debug-keep-process-buffers t)

(setq jabber-account-list `((,jabber-eterhost-user
                             (:password . ,jabber-eterhost-password)
                             (:network-server . "eterhost.org")
                             (:port . 5222))
                            ("140358@token1.localhost/wotba"
                             (:network-server . "localhost")
                             (:port . 5222))))
			    ;; (,jabber-dukgo-user
			    ;;  (:password . ,jabber-dukgo-password)
			    ;;  (:network-server . "dukgo.com")
			    ;;  (:port . 5222))))

(jabber-mode-line-mode)

(global-set-key (kbd "s-j") 'jabber-connect-all)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-jabber.el ends here
