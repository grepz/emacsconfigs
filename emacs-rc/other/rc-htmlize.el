;;; rc-htmlize.el ---
;;
;; Filename: rc-htmlize.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:08:44 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sat Nov  8 02:08:49 2014 (+0800)
;;           By: Stanislav M. Ivankin
;;     Update #: 2
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


(require 'htmlize)

(eval-after-load "htmlize"
  '(progn
     (defadvice htmlize-faces-in-buffer (after org-no-nil-faces activate)
       "Make sure there are no nil faces"
       (setq ad-return-value (delq nil ad-return-value)))))


(custom-set-variables
 '(htmlize-output-type 'inline-css)
 '(htmlize-html-major-mode 'html-mode))

;;(setq debug-on-error nil)

(defun my-reparse-htmlize-buffer ()
  (interactive)
  (message "htmlize buffer is: %s" (buffer-name))
  (save-excursion
    (save-restriction
      (save-match-data
	(widen)
	(goto-char (point-min))
	(search-forward "<pre>" nil t)
	(delete-region (point-min) (point))
	(insert (format
		 "<table width=\"100\" cellspacing=\"1\" cellpadding=\"5\" border=\"0\" bgcolor=\"%s\">
<tr><td width=\"100%%\">
<font color=\"%s\">
<b><pre>"
		 (frame-parameter nil 'background-color)
		 (frame-parameter nil 'foreground-color)))
	(goto-char (point-max))
	(search-backward "</pre>" nil t)
	(delete-region (point) (point-max))
	(insert "</pre></b>
</font>
</td></tr>
</table>")))))

(add-hook 'htmlize-after-hook 'my-reparse-htmlize-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-htmlize.el ends here
