;;; rc-desktop.el ---
;;
;; Filename: rc-desktop.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Wed Nov 19 07:42:07 2014 (+0300)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Wed Mar  9 21:32:23 2016 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 3
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


(require 'desktop)

(desktop-save-mode 1)

(mapc
 (lambda (symbol)
   (add-to-list 'desktop-globals-to-save symbol))
 '((buffer-name-history      . 100)
   (undo-limit               . 500000)
   (dired-regexp-history     . 20)
   (extended-command-history . 100)
   (file-name-history        . 500)
   (grep-history             . 50)
   (minibuffer-history       . 100)
   (query-replace-history    . 60)
   (read-expression-history  . 60)
   (regexp-history           . 60)
   (regexp-search-ring       . 20)
   (search-ring              . 20)
   (shell-command-history    . 50)))

(setq-default desktop-missing-file-warning nil
              desktop-dirname "~/emacs/tmp/desktop"
			  desktop-path '("~/emacs/tmp/desktop")
			  desktop-save t
			  desktop-save-mode t
			  save-place t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-desktop.el ends here
