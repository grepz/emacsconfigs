;; Elisp source code header -*- coding: utf-8 -*-
;; Created:  [02-09:15 Февраль 21 2008]
;; Modified: [21.39:13 Июль 21 2012]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(require 'tramp)
(require 'tramp-cmds)

;; sudo hack found on emacswiki

(setq tramp-default-method "scp"
      tramp-default-user "root"
      tramp-auto-save-directory "~/emacs/tmp/tramp-autosave")

(defvar find-file-root-prefix
  (if (featurep 'xemacs)
      "/[sudo/root@localhost]"
    "/sudo:root@localhost:" )
  "*The filename prefix used to open a file with `find-file-root'.")

(defvar find-file-root-history nil
  "History list for files found using `find-file-root'.")

(defvar find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun find-file-root ()
  "*Open a file as the root user.
   Prepends `find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."
  (interactive)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
   	 ;; use a separate history list for "root" files.
   	 (file-name-history find-file-root-history)
   	 (name (or buffer-file-name default-directory))
   	 (tramp (and (tramp-tramp-file-p name)
   		     (tramp-dissect-file-name name)))
   	 path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path buffer-file-name
   	    dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'find-file-root-hook))))

(global-set-key [(control x) (control r)] 'find-file-root)

(defvar host-hash (make-hash-table))

;; Tramp host autocompletion

(defun* my-add-host-to-tramp (host &key
				   (alias nil)
				   (user tramp-default-user)
				   (port "22")
				   (method tramp-default-method))
  (setf (gethash (if (null alias) (intern host) (intern alias)) host-hash)
	(concat "/" method ":" user "@" host "#" port ":~/")))

(defun hash-keys-to-list (hashtable)
  (let (key-list)
    (maphash (lambda (x y)
	       (setq key-list (cons x key-list)))
	     hashtable)
    key-list))

(defun my-tramp-connect-to-server ()
  (interactive)
  (let* ((host-list (mapcar #'symbol-name
			   (hash-keys-to-list host-hash)))
	 (host (completing-read
		"Host: " host-list nil t nil nil nil)))
    (when (length host)
      (find-file (read-file-name
		  "[Tramp]"
		  (gethash (intern host) host-hash))))))

(global-set-key [(s x) (r)] 'my-tramp-connect-to-server)

(my-add-host-to-tramp "46.254.240.98" :alias "Work server"
		      :user "root" :port "58022")
