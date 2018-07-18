(defvar *emacs-load-start* (current-time))

(require 'cl)

(add-to-list 'load-path "~/elisp")

(setq my-system 'osx)
(load "~/emacs/emacs-rc/configuration")

(display-time-mode -1)

(setq custom-file "~/.emacs-custom.el")
(load custom-file 'noerror)

;; Must be first to load
(load "~/emacs/emacs-rc/helpers")

(add-subdirs-to-load-path "~/elisp")

(require 'package)
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(safe-load "~/emacs/emacs-rc/passwords.el.gpg")

(load-custom-rc-files "~/emacs/emacs-rc/looknfeel")
(load-custom-rc-files "~/emacs/emacs-rc/system")
(load-custom-rc-files "~/emacs/emacs-rc/devel")
(load-custom-rc-files "~/emacs/emacs-rc/network")
(load-custom-rc-files "~/emacs/emacs-rc/other")

;; Starting emacs server, so we can connect to it with commands:
;;  sh> emacsclient -t/-c
(server-start)

(message "Emacs loaded in %ds"
         (destructuring-bind (hi lo ms ps) (current-time)
           (- (+ hi lo) (+ (first *emacs-load-start*)
                           (second *emacs-load-start*)))))

;;(setq message-log-max t)

(message "Happy hacking, %s!" (user-login-name))
