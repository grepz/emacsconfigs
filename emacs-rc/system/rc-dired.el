;;; rc-dired.el ---
;;
;; Filename: rc-dired.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:08:11 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sat Nov  8 02:08:18 2014 (+0800)
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


;;;; Notes:
;; wdired-change-to-wdired-mode, then rename files, simple and fast.
;; {C-x ( ; C-x )} macro with dired
;; C-x j - dired jump(return from editable file for e.g.
;; M-! run command

(require 'dired)
(require 'dired-x)

;; OSX ls can't do long keys like --dired, so use gls from coreutils
(when (boundp 'aquamacs-version)
  (setf ls-lisp-use-insert-directory-program t
		insert-directory-program "gls"))

(setq dired-omit-files "^\\.?#\\|^\\.$\\|^INDEX$\\|^_darcs$\\|^CVS$\\|^.git$\\|^RCS$\\|^\\.svn$\\|,v$")

(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-omit-mode 1)))

(setq dired-use-ls-dired t
      dired-shell-command-history t)

(put 'dired-find-alternate-file 'disabled nil)

(define-key dired-mode-map [return] 'dired-find-alternate-file)
(define-key dired-mode-map [(a)] 'dired-advertised-find-file)

(define-key global-map (kbd "C-x j") 'dired-jump)

(setq auto-mode-alist
	  (cons '("[^/]\\.dired$" . dired-virtual-mode) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-dired.el ends here
