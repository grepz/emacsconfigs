;;; rc-erc.el ---
;;
;; Filename: rc-erc.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:09:39 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sat Nov  8 02:09:44 2014 (+0800)
;;           By: Stanislav M. Ivankin
;;     Update #: 2
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


(require 'erc)
(require 'erc-join)
(require 'erc-log)
(require 'erc-fill)

(erc-fill-mode t)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-erc.el ends here
