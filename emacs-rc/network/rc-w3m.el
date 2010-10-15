;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [12-37:32 Июль 20 2008]
;; Modified: [20.57:59 Октябрь 15 2010]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m/")

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

(require 'w3m-load)
(require 'w3m)
(require 'w3m-ccl)
;; Make mail clients happy with fucking html mail
(require 'mime-w3m)

(autoload 'w3m-antenna "w3m-antenna" "Report changes of web sites." t)

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
	  (set-process-sentinel proc (lambda (proc str)
				       (message "wget download done"))))
      (message "Nothing to get"))))

 (defun w3m-download-with-curl (loc)
  (define-key w3m-mode-map "c"
	(lambda (dir)
	  (interactive "Save to: ")
	  (cd dir)
	  (start-process "curl" "*curl*" "curl.exe" "-O" "-s" (w3m-anchor)))))

;; (defadvice url-cookie-host-can-set-p (before reddit-cookie-fix 'activate)
;;     (and (string= (ad-get-arg 0) "www.reddit.com")
;; 	 (string= (ad-get-arg 1) "reddit.com"))) 
