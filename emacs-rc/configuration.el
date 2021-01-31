;;; configuration.el ---
;;
;; Filename: configuration.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Wed Nov 12 00:49:28 2014 (+0300)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Вс янв 31 22:49:44 2021 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 14
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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; configuration.el ends here

(setq erlang-root
	  (case my-system
		('osx   "~/erlang/erlang")
		('linux "/usr/lib/erlang")))

(when (eq my-system 'osx)
  (setenv "PATH" (concat (getenv "PATH")
                         ":/opt/local/bin"
                         ":~/arm-none-eabi/bin"
                         ":/opt/local/bin"
                         ":/opt/local/sbin"
                         ":~/bin:/opt/local/lib/mysql55/bin"
                         ":/opt/local/lib/postgresql95/bin/"
                         ":/opt/local/libexec/gnubin/"
                         ":/Applications/Emacs.app/Contents/MacOS/bin/"))
  (setq exec-path (append exec-path '("/opt/local/bin"))))

(setq-default erlang-root-dir erlang-root)
(setq-default erlang-man-root-dir (concatenate 'string erlang-root "/man"))

(add-to-list 'exec-path (concatenate 'string erlang-root "/bin"))

;; Make gpg2 happy about entering password in minibuffer
(setq epa-pinentry-mode 'loopback)
