;;; -*- Mode: Emacs-Lisp; Coding:utf-8 -*-

(require 'cl)

(load-file "helpers.el")

(add-subdirs-to-load-path "~/elisp")
(add-subdirs-to-load-path "~/emacs/emacs-rc/extensions")

(defun compile-rc-files (rc-dir)
  (let ((categories 
	 (filter #'(lambda (x)
		     (file-directory-p x)) 
		 (directory-files "/home/esgal/emacs/emacs-rc/" t "^[^.]"))))
    (loop for category in categories 
	  collect (directory-files category t "^rc-[^/]+?\.el$"))))

(setq compile-list 
      (reduce '(lambda (x y) (concatenate 'list x y)) 
	      (compile-rc-files ".")))

(dolist (file compile-list)
  (byte-compile-file file))
