;;; rc-gobject.el --- Auto creator of GObject skeleton files

;; Copyright (C) 2008  Stanislav M. Ivankin

;; Author: Stanislav M. Ivankin <stas@concat.info>
;; Keywords: c, oop, extensions

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(setq separate-private t)

(defun gobj-validate-input (input)
  (when (string-match "^[^0-9_][a-zA-Z0-9_]+[^_]$" input) t))

(defun gobj-read-string (prompt)
  (loop for x = (read-string prompt) do
	(unless (zerop (length x))
	  (if (gobj-validate-input x)
	      (return x)))))

(defun CapitalizeGtkName (name)
  (reduce #'concat (mapcar #'capitalize (split-string name "_"))))

(defun gobj-create-buffers (package object &optional private)
  (let ((buffer-name (concat package "-" object)))
   (values (get-buffer-create
	    (generate-new-buffer-name (concat buffer-name ".c")))
	   (get-buffer-create
	    (generate-new-buffer-name (concat buffer-name ".h")))
	   (when private
	     (get-buffer-create
	      (generate-new-buffer-name (concat buffer-name "-private.h")))))))

'("PACKAGE_OBJECT" "PACKAGE_IS_OBJECT" "PackageObject")
Derived:
'("PACKAGE_OBJECT_CLASS" "PACKAGE_IS_OBJECT_CLASS" "PackageObjectClass")

"PACKAGE_OBJECT_GET_CLASS"

(defmacro gobj-obj-type (package object)
  `(concat ,(upcase package) "_TYPE_" ,(upcase object)))
(defmacro gobj-obj (package object)
  `(concat ,(upcase package) "_" (upcase object)))
(defmacro gobj-is-obj (package object)
  `(concat ,(upcase package) "_IS_" (upcase object)))
(defmacro gobj-obj-class (package object)
  `(concat ,(upcase package) "_" (upcase object) "_CLASS"))
(defmacro gobj-obj-is-class (package object)
  `(concat ,(upcase package) "_IS_" (upcase object) "_CLASS"))
(defmacro gobj-obj-get-class (package object))


(

(defun gobj-create-skeleton ()
  (interactive)
  (let ((private (y-or-n-p "Create private")))
    (multiple-value-bind (package object parent)
	(values-list (mapcar #'(lambda (x)
				 (downcase (gobj-read-string x)))
			     '("Package: " "Object: " "Parent: ")))
      (multiple-value-bind (source header private)
	  (gobj-create-buffers package object separate-private)
	(generate-header-contents header
	      package object parent)
	(generate-private-contents private
	      package object separate-private))
	(generate-source-contents source
	      package object parent separate-private))))

(provide 'rc-gobject)
;;; rc-gobject.el ends here
