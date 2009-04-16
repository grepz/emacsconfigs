;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [01-27:32 Май 11 2008]
;; Modified: [15.16:35 Апрель 09 2009]
;; Description:
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: elisp, emacs
;; License: 

(eval-when-compile
  (require 'cl))

(defun filter (func lst) 
  (cond ((null lst)  '())
	((funcall func (car lst)) 
	 (cons (car lst) (filter func (cdr lst))))
	(t (filter func (cdr lst)))))

(defun change-execution-bit(&optional unmake)
  "If file is writable, exists and not executable already,
then add execution bit. If file is executable and unmake is
set to t, then remove execution bit"
  (interactive)
  (let ((buf (buffer-file-name)))
    (unless (or (null buf)
		(not (file-exists-p buf))
		(not (file-writable-p buf)))
      (if (file-executable-p buf)
	  (unless (not unmake)
	    (message "Execution bit unset")
	    (set-file-modes buf (- (file-modes buf) 64)))
	(progn
	  (message "Execution bit is set")
	  (set-file-modes buf (+ (file-modes buf) 64)))))))

(defun notebook-location (interface)
  "Where am i? ... Who am i? ... Drinking last bottle wasn't a good idea."
  (let ((netconf (shell-command-to-string "/sbin/ifconfig")))
    (let ((interface_pos (string-match (concat interface "\ +") netconf)))
      (if (null interface_pos)
	  nil
	(substring netconf
		   (+ (string-match "inet addr:" netconf interface_pos) 10)
		   (- (string-match " Bcast:" netconf interface_pos) 1))))))

(defconst +emacs-build-version+
  (string-to-number 
   (substring emacs-version 
	      (string-match "[0-9]+\\.[0-9]+$" emacs-version) 
	      (string-match "\\.[0-9]+$" emacs-version)))
  "Emacs minor build version")

(defun insert-date ()
  "Insert date at point"
  (interactive)
  (insert (format-time-string "%H-%M:%S %B %d %Y" (current-time))))

(global-set-key (kbd "s-d") 'insert-date)

(defun find-in-lst (list str)
  "Find string in list"
  (catch 'ret
    (dolist (liststr list)
      (when (string= str liststr)
	(throw 'ret t)))
    (throw 'ret nil)))

(defun make-my-face (face bg fg &optional b i u)
  "Create custom face, face is a font-lock face symbol
bg - background;
fg - foreground;
Optional:
b  - bold
i  - itallic
u  - underline"
  (make-face face)
  (set-face-background face bg)
  (set-face-foreground face fg)
  (set-face-bold-p face b)
  (set-face-italic-p face i)
  (set-face-underline-p face u))

;;(defmacro add-fontlocked-keywords (mode keywords face)
;;  "Make keyword regexp colorfull"
;;  `(font-lock-add-keywords
;;    ,mode '((,(eval keywords) 1 ,face prepend))))

(defmacro add-fontlocked-keywords (mode keywords face)
  `(font-lock-add-keywords
    ,mode '((,(eval (concat (regexp-opt (eval keywords) t) ":"))
	     1 ,face prepend))))

;; Found this method on the net
(defun safe-load (library)
  (condition-case err
      (load library)
    (error
     (progn
       (message "Error with %s: %s" library err)
       (sleep-for 3)))))

(defun parse-mailencoded-string (string coding)    
  (let ((encstr (base64-encode-string (encode-coding-string string coding))))
    (substring encstr 0 (- (length encstr) 1))))

(defmacro* save-r/e/md (&rest body)
  `(save-excursion
     (save-restriction
       (save-match-data
	 ,@body))))

(defun files-listing-action (dir action recursive filter)
  "Get dir listing, action is taken on files"
  (when (file-directory-p dir)
    (or (char-equal ?/ (aref dir (1- (length dir))))
	(setq dir (file-name-as-directory dir)))
    (dolist (elem (directory-files dir))
      (cond ((member elem '("." "..")))
	    ((file-directory-p (concat dir elem))
	     (when recursive
	       (files-listing-action (concat dir elem) action recursive filter)))
	    (t (if filter
		   (unless (string-match filter (concat dir elem))
		     (funcall action (concat dir elem)))
		 (funcall action (concat dir elem))))))))

;; Function contributed by someone from emacswiki.org, thanks :)
(defun add-subdirs-to-load-path (dir)
  "Recursive add directories to `load-path'."
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))

(defun load-custom-rc-files (rc-dir &optional rc-filter)
  (dolist (file (filter #'(lambda (x)
			    (unless (member x rc-filter) x))
			(directory-files rc-dir t "^rc-[^/]+?\.el$")))
    (safe-load file)))
