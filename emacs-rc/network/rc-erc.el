;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [12-32:17 Июль 20 2008]
;; Modified: [22-56:32 Июль 20 2008]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(require 'erc)
(require 'erc-join)

(require 'erc-fill)
(erc-fill-mode t)

(setq erc-user-full-name "Stas M. Ivankin")
(setq erc-email-userid "stas@concat.info")

(require 'erc-log)
(setq erc-log-insert-log-on-open nil
      erc-log-channels t
      erc-log-channels-directory "~/emacs/tmp/erclogs/"
      erc-save-buffer-on-part t
      erc-hide-timestamps nil
      erc-max-buffer-size 20000)

(defun erc-save-buffers-in-logs ()
  (interactive)
  (mapc (lambda(buf)
	  (save-excursion
	    (set-buffer buf)
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
(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-passwords
      '((freenode     (("grepz" . "")
                       ("grepz_" . "")))))

(custom-set-variables
 '(erc-encoding-coding-alist (quote (("#debian-russian" . cyrillic-koi8))))
 '(erc-nick "grepz")
 '(erc-nick-uniquifier "_")
 '(erc-prompt-for-password t))
