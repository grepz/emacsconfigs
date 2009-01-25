(defvar *emacs-load-start* (current-time))

(setq debian-emacs-flavor 'emacs23)

;;(require 'timeclock)
(display-time-mode -1)

(setq custom-file "~/.emacs-custom.el")
(load custom-file 'noerror)

(add-to-list 'load-path "~/.emacs.d")

(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/elisp/bbdb/lisp")
(add-to-list 'load-path "~/elisp/ecb")
(add-to-list 'load-path "~/elisp/emacs-jabber")
(add-to-list 'load-path "~/elisp/yasnippet")
(add-to-list 'load-path "~/elisp/haskell-mode")
(add-to-list 'load-path "~/elisp/emms/lisp")
(add-to-list 'load-path "~/elisp/color-theme")
(add-to-list 'load-path "~/elisp/http-emacs")
(add-to-list 'load-path "~/elisp/ljupdate")
(add-to-list 'load-path "~/elisp/muse/lisp")
(add-to-list 'load-path "~/elisp/doxymacs/lisp")
(add-to-list 'load-path "~/elisp/devscripts")
(add-to-list 'load-path "~/elisp/apt")
(add-to-list 'load-path "~/elisp/redshank")
(add-to-list 'load-path "~/elisp/icicles")

(add-to-list 'load-path "~/elisp/apel")
(add-to-list 'load-path "~/elisp/emu")
(add-to-list 'load-path "~/elisp/flim")
(add-to-list 'load-path "~/elisp/semi")
(add-to-list 'load-path "~/elisp/wl/utils")
(add-to-list 'load-path "~/elisp/wl")

(add-to-list 'load-path "~/elisp/elscreen")

;; Common lisp compatibility
(require 'cl)

;; Must be first to load
(load "~/emacs/emacs-rc/helpers")

(safe-load "~/emacs/emacs-rc/rc-theme")
(safe-load "~/emacs/emacs-rc/rc-feel")

(safe-load "~/emacs/emacs-rc/rc-features")
(safe-load "~/emacs/emacs-rc/rc-bbdb")
(safe-load "~/emacs/emacs-rc/rc-dired")
(safe-load "~/emacs/emacs-rc/rc-occur")
(safe-load "~/emacs/emacs-rc/rc-org")
(safe-load "~/emacs/emacs-rc/rc-desktop")

(safe-load "~/emacs/emacs-rc/rc-devel")
(safe-load "~/emacs/emacs-rc/rc-autoinsert")
(safe-load "~/emacs/emacs-rc/rc-caml")
(safe-load "~/emacs/emacs-rc/rc-lisp")
(safe-load "~/emacs/emacs-rc/rc-haskell")
(safe-load "~/emacs/emacs-rc/rc-perl")
(safe-load "~/emacs/emacs-rc/rc-python")
(safe-load "~/emacs/emacs-rc/rc-ccmode")
(safe-load "~/emacs/emacs-rc/rc-cedet")
(safe-load "~/emacs/emacs-rc/rc-ecb")
(safe-load "~/emacs/emacs-rc/rc-ide-skel")
(safe-load "~/emacs/emacs-rc/rc-headers")

(safe-load "~/emacs/emacs-rc/rc-net")
(safe-load "~/emacs/emacs-rc/rc-erc")
(safe-load "~/emacs/emacs-rc/rc-tramp")
(safe-load "~/emacs/emacs-rc/rc-htmlize")
(safe-load "~/emacs/emacs-rc/rc-w3m")
(safe-load "~/emacs/emacs-rc/rc-jabber")
(safe-load "~/emacs/emacs-rc/rc-muse")

(safe-load "~/emacs/emacs-rc/rc-music")

;;(require 'gnus)

;; Wanderlust
(safe-load "~/.wl")

;; Starting emacs server, so we can connect to it with commands: emacsclient -t/-c
(server-start)

;; Must be last to load
(safe-load "~/emacs/emacs-rc/passwords.el.gpg")

(message "Emacs loaded in %ds" (destructuring-bind (hi lo ms) (current-time)
				 (- (+ hi lo) (+ (first *emacs-load-start*) (second *emacs-load-start*)))))

(message "Happy hacking, %s!" (user-login-name))
