(defvar *emacs-load-start* (current-time))

(add-to-list 'load-path "~/elisp")

(require 'cl)

(setq my-system 'linux)
(load "~/emacs/emacs-rc/configuration")

(display-time-mode -1)

(setq custom-file "~/.emacs-custom.el")
(load custom-file 'noerror)

;; Must be first to load
(load "~/emacs/emacs-rc/helpers")

(add-subdirs-to-load-path "~/elisp")

(require 'package)
;; Elpa package system for Emacs
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

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

(defalias 'string-to-int 'string-to-number)

;;(setq message-log-max t)

(message "Happy hacking, %s!" (user-login-name))
