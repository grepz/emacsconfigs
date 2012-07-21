;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-03:27 Июль 19 2008]
;; Modified: [21.42:05 Июль 21 2012]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

(require 'org)

(add-hook 'org-mode-hook #'(lambda ()
			     (auto-fill-mode 1)))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

;;(defvar *orgplace* "~/emacs/etc/orgmode/")

(setq org-log-done '(done))

(add-hook 'remember-mode-hook 'org-remember-apply-template)

(custom-set-variables
 '(org-directory "~/emacs/etc/orgmode/")
 '(org-mobile-directory "~/emacs/etc/orgmode/mobile")
 '(org-mobile-inbox-for-pull "~/emacs/etc/orgmode/mobile/from-mobile.org")
 '(org-agenda-files (list "~/emacs/etc/orgmode/work.org"))
 '(org-default-notes-file "~/emacs/etc/orgmode/all.org")
 '(org-agenda-ndays 7)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-remember-store-without-prompt t)
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler)))
 '(org-agenda-custom-commands
   '(("h" "Home related tasks"
      ((tags-todo "@HOME")))
     ("w" "Work related tasks"
      ((tags-todo "@WORK"))))))
