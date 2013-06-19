;;; -*- Mode: Emacs-Lisp; Coding:utf-8 -*-

(require 'cl)

(load-file "helpers.el")

(add-subdirs-to-load-path "~/elisp")

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
