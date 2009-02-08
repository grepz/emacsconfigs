;;; ede-ext.el --- Extensions to EDE mode

;; Copyright (C) 2009  Stanislav M. Ivankin

;; Author: Stanislav M. Ivankin <stas@concat.info>
;; Keywords: tools, languages

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

(eval-when-compile
  (require 'cl))

(require 'ede-cpp-root)

;;;###autoload
(defclass ede-cpp-root-project-ext (ede-cpp-root-project)
  ((coding-style :initform "k&r"
		 :initarg :coding-style
		 :type string
		 :documentation "Coding style used for the project")))

(defmethod ede-project-coding-style ((self ede-cpp-root-project-ext))
  (oref self coding-style))

(provide 'ede-ext)
;;; ede-ext.el ends here
