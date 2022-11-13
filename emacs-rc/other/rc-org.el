;;; rc-org.el ---
;;
;; Filename: rc-org.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:09:14 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Чт окт 27 00:15:08 2022 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 39
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-org.el ends here
