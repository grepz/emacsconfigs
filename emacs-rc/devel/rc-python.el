;;; rc-python.el --- Python mode improvements

;; Copyright (C) 2008  Stanislav M. Ivankin

;; Author: Stanislav M. Ivankin <stas@concat.info>
;; Keywords: languages, tools

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

(setq ipython-command "/usr/bin/ipython")

(require 'python-mode)
(require 'ipython)
(require 'pymacs)

;;(load "~/elisp/pylint")

;;(pymacs-load "ropemacs" "rope-")

(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

(defun my-python-documentation (w)
  "Launch PyDOC on the Word at Point"
  (interactive
   (list (let* ((word (thing-at-point 'word))
		(input (read-string 
			(format "pydoc entry%s: " 
				(if (not word) "" (format " (default %s)" word))))))
	   (if (string= input "") 
	       (if (not word) (error "No pydoc args given")
		 word) ;sinon word
	     input)))) ;sinon input
  (shell-command (concat py-python-command " -c \"from pydoc import help;help(\'" w "\')\"") "*PYDOCS*")
  (view-buffer-other-window "*PYDOCS*" t 'kill-buffer-and-window))


(defun my-python-mode-hook ()
  (local-set-key [return] 'newline-and-indent)
  (local-set-key (kbd "\C-c#") 'comment-region)
  (local-set-key (kbd "\C-hf") 'my-python-documentation)
  (eldoc-mode 1)
  (linum-mode 1))
;;  (local-set-key [f1] 'pylint)
;;  (local-set-key [f2] 'previous-error)
;;  (local-set-key [f3] 'next-error))

(add-hook 'python-mode-hook 'my-python-mode-hook)

;;; rc-python.el ends here
