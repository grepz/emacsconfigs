;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [22.57:45 Сентябрь 01 2008]
;; Modified: [05.49:30 Декабрь 19 2008]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(require 'autoinsert)
(auto-insert-mode)

(setq auto-insert-directory "~/emacs/etc/autoinsert/")
;;(add-to-list auto-insert-alist
;;	     '(("\\.pl$" . ["perl-template.pl"  autoinsert-perl-source-file])
;;	       ("\\.el$" . ["elisp-template.el" autoinsert-elisp-source-file])))

;;(setq auto-insert-alist '(("\\.pl$" . ["perl-template.pl"  autoinsert-perl-source-file])
;;			  ("\\.el$" . ["elisp-template.el" autoinsert-elisp-source-file])))

;;(setq auto-insert 'other)
(setq auto-insert t)

(defconst +perl-inc-dirs+ (split-string (shell-command-to-string "perl -e 'print \"@INC\"'")))

(defun* perlify-path (module-path)
  (unless (string-match "\.pm$" module-path)
    (return-from perlify-path))
  (loop for path in +perl-inc-dirs+ do
	(when (string-match (concat "^" path) module-path)
	  (return (replace-regexp-in-string "/" "::"
		    (substring module-path
			       (+ (length path) 1)
			       (- (length module-path) 3)))))))

(defun get-perl-modules (dir &optional recursive)
  (or (char-equal ?/ (aref dir (1- (length dir))))
      (setq dir (file-name-as-directory dir)))
  (loop for elem in (directory-files dir)
	do (cond ((member elem '("." "..")) nil)
		 ((file-directory-p (concat dir elem))
		  (when recursive
		    (get-perl-modules (concat dir elem))))
		 (t (append lst (perlify-path (concat dir elem)))))))

(defun get-perl-modules (dir &optional recursive)
  (let (lst)
    (loop for x in +perl-inc-dirs+ do
	  (files-listing-action x #'(lambda (x)
				      (when (perlify-path x)
					(push (perlify-path x) lst))) t nil))
    lst))

;;  perl -MFile::Find=find -MFile::Spec::Functions -Tlwe 'find { wanted => sub { print canonpath $_ if /\.pm\z/ }, no_chdir => 1 }, @INC'

(defun autoinsert-perl-source-file ()
  (let ((use-packages '())
	(avail-packages '("strict" "warnings")))
;;	(avail-packages (get-perl-modules +perl-inc-dirs+ t)))
    (loop for answ = (completing-read 
	 "Packages: " avail-packages nil t nil nil nil) do
	 (progn
	   (unless (zerop (length answ))
	     (add-to-list 'use-packages answ)))
	 until (zerop (length answ)))
    (save-restriction
      (goto-line 3)
      (dolist (package use-packages)
	(insert (concat "use " package ";\n")))))
  (while (search-forward "DDDD" nil t)
    (save-restriction
      (narrow-to-region (match-beginning 0) (match-end 0))
      (replace-match
       (format-time-string "%H.%M:%S %B %d %Y" (current-time))))))

(defun autoinsert-elisp-source-file ())
