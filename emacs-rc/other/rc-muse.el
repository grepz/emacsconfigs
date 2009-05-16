;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [22-55:36 Май 19 2008]
;; Modified: [01.34:54 Май 17 2009]
;; Description:
;;  The idea of using muse as a site backend and some code was taken from Alex Ott
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: muse, emacs, elisp
;; License:

(eval-when-compile (require 'cl))

(require 'muse)
(require 'muse-mode)
(require 'muse-publish)
(require 'muse-html)
(require 'muse-project)
(require 'muse-colors)
(require 'muse-wiki)

(defvar concat.info-muse-menu '(("index.html" . "Главная")
				("emacs/" . "Дот файлы emacs и прочее")
				("about/" . "CV")
				("about/more-about.html" . "Немного за жисть")
				("literature/" . "Литература"))
  "Site main menu")

(defvar my-muse-publish-files '()
  "Files to publish with muse project")

(files-listing-action
 "/home/esgal/emacs/emacs-rc/"
 #'(lambda (x)
     (add-to-list 'my-muse-publish-files x)) t "\\.elc$")

(defvar my-muse-protected-files '("/home/esgal/emacs/emacs-rc/passwords.el")
  "Files that needs to be edited before publishing")

(defun my-muse-mode-hook ()
  (auto-fill-mode t)
  (footnote-mode 1))

(defun set-rel-path ()
  (file-name-directory (muse-wiki-resolve-project-page (muse-project))))

(defun my-muse-prepare-els ()
  "Prepare el files to publish with concat.info muse project,
if files has some private data, clean it first by hand"
  (interactive)
  (dolist (file my-muse-publish-files)
    (if (find-in-lst my-muse-protected-files file)
	(let ((buf (generate-new-buffer (concat "concat.info->" file))))
	  (switch-to-buffer buf)
	  (emacs-lisp-mode)
	  (insert-file-contents file nil))
      (let ((pos (position ?/ file :from-end t))
	    (fname))
	(if pos
	    (setq fname (subseq file (1+ pos) (length file)))
	  (setq fname file))
	(htmlize-file file (concat (set-rel-path) "emacs/" fname ".html"))))))

(defun generate-concat.info-menu ()
  (let* ((current-muse-file (muse-current-file))
	 (link-path (replace-regexp-in-string "\\.muse" ".html" current-muse-file))
	 (dir (if (> (length (file-name-directory (muse-wiki-resolve-project-page (muse-project)))) 2)
		  "../"
		"")))
    (apply #'concat
	   (mapcar #'(lambda (x) (concat "<li><a href=\"" dir (car x) "\">" (cdr x) "</a></li>"))
		   concat.info-muse-menu))))

(add-to-list 'auto-mode-alist '("\\.muse$" . muse-mode))
(custom-set-variables
 '(muse-html-encoding-default (quote utf-8))
 '(muse-html-meta-content-encoding (quote utf-8))
 '(muse-html-charset-default "utf-8")
 '(muse-file-extension "muse")
 '(muse-mode-auto-p nil)
 '(muse-wiki-allow-nonexistent-wikiword nil)
 '(muse-wiki-use-wikiword nil)
 '(muse-ignored-extensions (quote ("bz2" "gz" "[Zz]" "rej" "orig" "png" "hgignore" "gif"
				   "css" "jpg" "html" "sh" "lftp" "pdf"))))

(add-hook 'muse-mode-hook 'my-muse-mode-hook)

(muse-derive-style "concat-info-muse-html" "html"
                   :header "~/Projects/concat.info/muse/header.tmpl"
                   :footer "~/Projects/concat.info/muse/footer.tmpl")

(setq muse-project-alist `(("muse-concat-info"
			    (,@(muse-project-alist-dirs  "~/Projects/concat.info/muse/") :default "index")
			    ,@(muse-project-alist-styles "~/Projects/concat.info/muse/"
							 "~/Projects/concat.info/muse/"
							 "concat-info-muse-html"))))


(require 'thumb-page)
