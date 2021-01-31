;;; rc-features.el ---
;;
;; Filename: rc-features.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:08:29 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Вс янв 31 22:58:00 2021 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 6
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


(custom-set-variables
 '(undo-limit 500000))

;;;;;;;;;;;;;;;;;;;;;;
;; Storing tmpfiles ;;

(defvar tmp-autosave-dir "~/emacs/tmp/autosave/")
(defvar backup-dir "~/emacs/tmp/backup/")

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat tmp-autosave-dir
	  (if buffer-file-name
	      (concat "#" (file-name-nondirectory buffer-file-name) "#")
	    (expand-file-name
	     (concat "#%" (buffer-name) "#")))))

(setq backup-directory-alist (list (cons "." backup-dir)))

;; Elpa package system for Emacs
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;;
;; Frequency of keys pressed during session
;;

;; (require 'keyfreq)

;; (keyfreq-mode 1)
;; (keyfreq-autosave-mode 1)

;;
;; Easy to use occur on buffers opened
;;

;; (require 'color-moccur)

;; (setq *moccur-buffer-name-exclusion-list*
;;       '(".+TAGS.+" "*Completions*" "*Messages*" ".bbdb" "\\.txt$"))

;; (global-set-key "\C-c\C-s" 'moccur)
;; (global-set-key "\C-c\C-d" 'moccur-grep-find)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-features.el ends here
