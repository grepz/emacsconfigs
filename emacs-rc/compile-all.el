;;; compile-all.el ---
;;
;; Filename: compile-all.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:10:55 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Вс янв 31 22:58:52 2021 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 5
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

(load-file "helpers.el")

(add-subdirs-to-load-path "~/elisp")
(add-subdirs-to-load-path "~/.emacs.d/el-get")

(require 'package)
(package-initialize)

(defun compile-rc-files (rc-dir)
  (let ((categories
	 (filter #'(lambda (x)
		     (file-directory-p x))
		 (directory-files "~/emacs/emacs-rc/" t "^[^#.]"))))
    (loop for category in categories
	  collect (directory-files category t "^rc-[^/]+?\.el$"))))

(setq compile-list
      (reduce '(lambda (x y) (concatenate 'list x y))
	      (compile-rc-files ".")))

(dolist (file compile-list)
  (unless (byte-compile-file file)
    (error "Can't compile file '%s'" file)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; compile-all.el ends here
