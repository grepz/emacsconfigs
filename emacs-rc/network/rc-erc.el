;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.39:27 Январь 07 2014]
;; Modified: [14.51:52 Январь 07 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: elisp,emacs,erc
;; License: GPLv3
;;  ---------------------------
;; Description:

(require 'erc)
(require 'erc-join)

(require 'erc-fill)

(erc-fill-mode t)

(require 'erc-log)

(custom-set-variables 
 '(erc-log-insert-log-on-open nil)
 '(erc-log-channels t)
 '(erc-log-channels-directory "~/emacs/tmp/erclogs/")
 '(erc-save-buffer-on-part t)
 '(erc-hide-timestamps nil)
 '(erc-max-buffer-size 20000)
 '(erc-user-full-name "Stas M. Ivankin")
 '(erc-email-userid "stas@concat.info")
 '(erc-prompt-for-nickserv-password nil)
 '(erc-nickserv-passwords
   '((freenode     (("grepz" . "")
		    ("grepz_" . "")))))
 '(erc-nick "grepz")
 '(erc-nick-uniquifier "_")
 '(erc-prompt-for-password t))

(defun erc-save-buffers-in-logs ()
  (interactive)
  (mapc (lambda (buf)
	  (with-current-buffer buf
	    (erc-save-buffer-in-logs)))
	(erc-buffer-filter (lambda() t))))

(defadvice save-buffers-kill-emacs
  (before save-logs-before-save-buffers-kill-emacs (&rest args) activate)
  'erc-save-buffers-in-logs)

(defadvice save-some-buffers
  (before save-logs-before-save-some-buffers (&rest args) activate)
  'erc-save-buffers-in-logs)

(require 'erc-services)

(erc-nickserv-mode 1)
