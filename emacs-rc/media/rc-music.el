;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-03:22 Июль 19 2008]
;; Modified: [14.53:54 Февраль 23 2010]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;;;;;;;;;;;;;;;;;;;
;; Music playing ;;

;;(global-set-key (kbd "s-m") 'emms)
(autoload 'emms "emms-setup" t)

(eval-after-load "emms-setup"
  '(progn
     (message "-> emms loaded")
     (emms-devel)
     (emms-default-players)
     (require 'emms-mode-line)
     (require 'emms-playing-time)
     (emms-mode-line 1)
     (emms-playing-time 1)
     (require 'emms-player-simple)
     (require 'emms-source-file)
     (require 'emms-source-playlist)
     (require 'emms-streams)
     (require 'emms-info)
;;     (add-to-list 'emms-player-list 'emms-player-mpd)
;;     (add-to-list 'emms-info-functions 'emms-info-mpd)
;;     (setq emms-player-mpd-server-name "localhost"
;;	   emms-player-mpd-server-port "6600"
;;	   emms-player-mpd-music-directory "/var/lib/mpd/music")
     (add-hook 'emms-player-started-hook 'emms-show)
     (setq emms-mode-line-titlebar-function 'emms-mode-line-playlist-current
	   emms-volume-amixer-control "PCM"
	   emms-show-format "NP: %s"
	   emms-score-file "~/.emacs.d/emms-score"
	   emms-history-file "~/.emacs.d/emms-history"
	   emms-cache-file "~/.emacs.d/emms-cache"
	   emms-stream-bookmarks-file "~/emms-bookmarks"
	   emms-stream-default-action "play")
;;	   emms-source-file-default-directory "/var/lib/mpd/music/")
     (emms-lastfm-enable)))

;; MPD client

(global-set-key (kbd "s-m") 'mpc)
(autoload 'mpc "~/elisp/mpc/mpc-autoloads")

;;(eval-after-load "mpc-autoloads"
;;  '(progn
;;     (global-set-key (kbd "s-s") 'mpc-stop)))
