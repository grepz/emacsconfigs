;;; rc-org.el ---
;;
;; Filename: rc-org.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:09:14 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sat Jan 18 15:57:57 2025 (+0100)
;;           By: Stanislav M. Ivankin
;;     Update #: 59
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


(use-package org
  :ensure org-contrib
  :mode (("\\.org$" . org-mode))
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c b" . org-switchb))
  :custom
  (org-log-done '(done))
  (org-directory "~/emacs/etc/org-mode/")
  (org-agenda-files (list "~/emacs/etc/org-mode/work.org" "~/emacs/etc/org-mode/life.org" "~/emacs/etc/org-mode/todo.org"))
  (org-default-notes-file "~/emacs/etc/org-mode/bookmarks.org")
  (org-agenda-ndays 7)
  (org-deadline-warning-days 14)
  (org-agenda-show-all-dates t)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-start-on-weekday nil)
  (org-reverse-note-order t)
  (org-fast-tag-selection-single-key (quote expert))
  (org-agenda-custom-commands
   '(("h" "Home related tasks"
      ((tags-todo "@HOME")))
     ("w" "Work related tasks"
      ((tags-todo "@WORK")))))
  :config
  (add-hook 'org-mode-hook
            #'(lambda ()
	            (set-default 'truncate-lines t)
	            (auto-fill-mode 1))))


(add-to-list 'load-path "~/elisp/org-wiki")

(use-package htmlize :ensure)
(use-package helm :ensure)

(require 'org-wiki)

(setq org-wiki-location-list
      '("~/emacs/etc/org-mode/mnemonic/"))

(setq org-wiki-template
      (string-trim
"
#+TITLE: %n
#+DESCRIPTION:
#+KEYWORDS:
#+OPTIONS: ^:nil
#+STARTUP:  content
#+DATE: %d

- [[wiki:index][Index]]

- Parent:

- Related:

* %n
"))

(setq org-wiki-location (car org-wiki-location-list))
;; Close all wiki pages when switching root
(setq org-wiki-close-root-switch t)

(setq org-wiki-server-host "127.0.0.1")
(setq org-wiki-server-port "22222")

(defun presentation/start ()
  ;; Hide the mode line
  (hide-mode-line-mode 1)
  ;; Display images inline
  (org-display-inline-images) ;; Can also use org-startup-with-inline-images
  ;; Scale the text.  The next line is for basic scaling:
  (setq text-scale-mode-amount 1)
  (text-scale-mode 1))

(defun presentation/end ()
  ;; Show the mode line again
  (hide-mode-line-mode 0)
  ;; Turn off text scale mode (or use the next line if you didn't use text-scale-mode)
  (text-scale-mode 0))
  ;; If you use face-remapping-alist, this clears the scaling:
  ;;(setq-local face-remapping-alist '((default variable-pitch default))))

(defun presentation-start ()
  (interactive)
  (org-tree-slide-mode))

(defun presentation-end ()
  (interactive)
  (org-tree-slide-mode -1))

(use-package org-tree-slide
  :ensure
  :hook ((org-tree-slide-play . presentation/start)
         (org-tree-slide-stop . presentation/end))
  :custom
  (org-tree-slide-slide-in-effect t)
  (org-tree-slide-activate-message "Presentation started!")
  (org-tree-slide-deactivate-message "Presentation finished!")
  (org-tree-slide-header t)
  (org-tree-slide-breadcrumbs " > ")
  (org-image-actual-width nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-org.el ends here
