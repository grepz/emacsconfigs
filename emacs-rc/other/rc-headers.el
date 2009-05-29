;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16.12:28 Июль 19 2008]
;; Modified: [16.48:37 Май 27 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(defvar myself "Stanislav M. Ivankin")
(defvar myemail "stas@concat.info")
(defvar my-coding-system "utf-8")

;; TODO: If we cant guess file type, try to guess
;; it from activated mode, then prompt user
(defun* my-define-file-type ()
  (let* ((buf ((lambda (x)
		 (if (null x) "" x)) buffer-file-name))
	 (infoheader
	   ((lambda ()
	      (cond
	       ((string-match  "\\.el$" buf)
		'("Elisp" ";; "))
	       ((string-match  "\\.lisp$" buf)
		'("Lisp" ";; "))
	       ((string-match "\\.\\(hs\\|hi\\)$" buf)
		'("Haskell" "-- "))
	       ((string-match "\\.\\(cpp\\|cc\\|hh\\|hpp\\)$" buf)
		'("C++" "// "))
	       ((string-match "\\.\\(c\\|h\\)$" buf)
		'("C" "// "))
	       ((string-match "\\.sh$" buf)
		'("Shell" "## "))
	       ((string-match "\\.pl$" buf)
		'("Perl" "## "))
	       (t '("File" "## ")))))))
    (list (concat (car infoheader) " source code header") (cadr infoheader))))

(defun update-my-info-header ()
  "If there is info header, changes its timestamp, when file is saved"
  (interactive)
  (let ((infoheader (my-define-file-type)))
    (unless (null infoheader)
      (save-r/e/md
       (widen)
       (goto-char (point-min))
       (when (search-forward (car infoheader) nil t)
	 (goto-line (+ (line-number-at-pos) 2))
	 (when (looking-at (concat (cadr (my-define-file-type)) "Modified: \\["))
	   (let ((start (+ (point)
			   (+ (length (cadr (my-define-file-type)))
			      (length "Modified: ["))))
		 (lpos (line-number-at-pos)))
	     (if (and (search-forward "]")
		      (= lpos (line-number-at-pos)))
		 (progn
		   (delete-region start (- (point) 1))
		   (goto-char start)
		   (insert (format-time-string "%H.%M:%S %B %d %Y" (current-time))))
	       (message "rc-headers.el: Can't find closing ']' on modification time")))))))))

(defun create-my-info-header ()
  "Creates info header for source code file"
  (interactive)
  (let ((exists nil) (infoheader (my-define-file-type)))
    (when infoheader
      (save-r/e/md
       (goto-char (point-min))
       (if (search-forward (car infoheader) nil t)
	   (message "Header already exists.")
	 (when (equal "y" (completing-read "Create info header?: " nil nil nil))
	   (goto-char (point-min))
	   (when (looking-at "#!")
	     (goto-line 2))
	   (let ((comment (cadr infoheader)))
	     (insert (concat comment (car infoheader) " -*- coding: " my-coding-system " -*-" "\n"
			     comment "Created: ["
			     (format-time-string "%H.%M:%S %B %d %Y" (current-time)) "]\n"
			     comment "Modified: [---]\n"
			     comment "Description: \n"
			     comment "Author: " myself "\n"
			     comment "Email: " myemail "\n"
			     comment "Tags: \n"
			     comment "License: \n\n")))))))))


(add-hook 'before-save-hook 'update-my-info-header)
