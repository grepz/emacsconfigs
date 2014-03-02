;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.37:34 Январь 07 2014]
;; Modified: [14.37:35 Январь 07 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: emacs,elisp,make
;; License: GPLv3
;;  ---------------------------
;; Description:

(require 'cl)

(load-file "helpers.el")

(add-subdirs-to-load-path "~/elisp")
(package-initialize)

(defun compile-rc-files (rc-dir)
  (let ((categories 
	 (filter #'(lambda (x)
		     (file-directory-p x)) 
		 (directory-files "~/emacs/emacs-rc/" t "^[^#.]"))))
    (loop for category in categories 
	  collect (directory-files category t "^rc-[^/]+?\.el$"))))

(setq compile-list 
      (reduce '(lambda (x y) (concatenate 'list x y)) 
	      (compile-rc-files ".")))

(dolist (file compile-list)
  (unless (byte-compile-file file)
    (error "Can't compile file '%s'" file)))
