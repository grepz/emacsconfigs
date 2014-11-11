;;; rc-w3m.el ---
;;
;; Filename: rc-w3m.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:09:57 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Tue Nov 11 18:47:34 2014 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 3
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


(add-to-list 'load-path "~/elisp/emacs-w3m/")

(custom-set-variables
 '(w3m-coding-system           'utf-8)
 '(w3m-file-coding-system      'utf-8)
 '(w3m-file-name-coding-system 'utf-8)
 '(w3m-input-coding-system     'utf-8)
 '(w3m-output-coding-system    'utf-8)
 '(w3m-terminal-coding-system  'utf-8)
 '(w3m-key-binding 'info)
 '(mime-w3m-display-inline-images t)
 '(w3m-default-display-inline-images t)
 '(w3m-toggle-inline-images-permanently t)
 '(w3m-use-cookies t)
 '(browse-url-browser-function 'w3m-browse-url-new-tab)
 '(w3m-home-page "about:blank")
 '(w3m-cookie-accept-bad-cookies t)
 '(w3m-cookie-accept-domains '("reddit.com" "livejournal.com"))
 '(browse-url-browser-function 'w3m-browse-url))

;;(require 'w3m-load)
(require 'w3m)
(require 'w3m-ccl)

(autoload 'w3m-antenna "w3m-antenna"
  "Report changes of web sites." t)

(defun w3m-new-tab ()
  (interactive)
  (w3m-copy-buffer nil nil nil t))

(global-set-key (kbd "s-t") 'w3m-new-tab)

(defun w3m-browse-url-new-tab (url &optional new-session)
  (interactive)
  (w3m-new-tab)
  (w3m-browse-url url))

(defun w3m-download-with-wget (loc)
  (interactive "DSave to: ")
  (let ((url (or (w3m-anchor) (w3m-image))))
    (if url
	(let ((proc (start-process "wget" (format "*wget %s*" url)
							   "wget" "--passive-ftp" "-nv"
							   "-P" (expand-file-name loc) url)))
	  (with-current-buffer (process-buffer proc)
	    (erase-buffer))
	  (set-process-sentinel proc
		(lambda (proc str)
		  (message "wget download done"))))
	(message "Nothing to get"))))

 (defun w3m-download-with-curl (loc)
  (define-key w3m-mode-map "c"
	(lambda (dir)
	  (interactive "Save to: ")
	  (cd dir)
	  (start-process "curl" "*curl*" "curl.exe" "-O" "-s" (w3m-anchor)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-w3m.el ends here
