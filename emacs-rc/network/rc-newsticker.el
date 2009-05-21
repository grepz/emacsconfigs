;;; rc-newsticker.el --- newsticker configuration

;; Copyright (C) 2009  Stanislav M. Ivankin

;; Author: Stanislav M. Ivankin <stas@concat.info>
;; Keywords: news, mail

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

(autoload 'newsticker-start "newsticker" "Emacs Newsticker" t)
(autoload 'newsticker-show-news "newsticker" "Emacs Newsticker" t)

(setq newsticker-url-list
      '(("EmacsWiki Recently Change"
         "http://www.emacswiki.org/emacs/index.rss" nil nil nil)
        ("Planet Emacsen"
	 "http://emacs.defun.ru/atom.xml" nil nil nil)
	("Kernel Trap"
	 "http://kerneltrap.org/node/feed" nil nil nil)))

(provide 'rc-newsticker)
;;; rc-newsticker.el ends here
