;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [00-56:39 Февраль 20 2008]
;; Modified: [19.33:32 Сентябрь 17 2008]
;; Description:
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: elisp, emacs
;; License: 

;; google-define
;;(require 'google-define)


;; http-emacs
(require 'http-cookies)
(require 'http-get)
(require 'http-post)

;;;;;;;;;;;;;;;;;
;; Livejournal ;;

(require 'ljupdate)
(setq lj-cache-dir "~/emacs/tmp/.ljupdate"
      lj-default-username "grep_z")

(dolist (hook '(lj-compose-mode))
  (add-hook hook (lambda () (flyspell-mode 1))))
