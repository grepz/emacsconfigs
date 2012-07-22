(defvar *emacs-load-start* (current-time))

(display-time-mode -1)

;; Common lisp compatibility
(require 'cl)

(setq custom-file "~/.emacs-custom.el")
(load custom-file 'noerror)

(add-to-list 'load-path "~/.emacs.d")

;; Must be first to load
(load "~/emacs/emacs-rc/helpers")

(add-subdirs-to-load-path "~/elisp")

(require 'package)

(load-custom-rc-files "~/emacs/emacs-rc/system")
(load-custom-rc-files "~/emacs/emacs-rc/looknfeel")
(load-custom-rc-files "~/emacs/emacs-rc/devel")
(load-custom-rc-files "~/emacs/emacs-rc/network")
(load-custom-rc-files "~/emacs/emacs-rc/other")

;; Must be last to load
(safe-load "~/emacs/emacs-rc/passwords.el.gpg")

;; Starting emacs server, so we can connect to it with commands: emacsclient -t/-c
(server-start)

(message "Emacs loaded in %ds" (destructuring-bind (hi lo ms) (current-time)
				 (- (+ hi lo) (+ (first *emacs-load-start*)
						 (second *emacs-load-start*)))))

(message "Happy hacking, %s!" (user-login-name))
