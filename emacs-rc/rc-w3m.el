;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [12-37:32 Июль 20 2008]
;; Modified: [04.38:25 Январь 26 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(require 'w3m-load)
(require 'w3m)
(require 'w3m-ccl)

(defun w3m-new-tab ()
  (interactive)
  (w3m-copy-buffer nil nil nil t))

(global-set-key (kbd "s-t") 'w3m-new-tab)

(defun w3m-browse-url-new-tab (url &optional new-session)
  (interactive)
  (w3m-new-tab)
  (w3m-browse-url url))

(setq browse-url-browser-function 'w3m-browse-url-new-tab)

(setq w3m-use-cookies t)

(setq w3m-home-page "about:blank")

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
	  (interactive "DSave to: ")
	  (cd dir)
	  (start-process "curl" "*curl*" "curl.exe" "-O" "-s" (w3m-anchor)))))

(setq w3m-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)
