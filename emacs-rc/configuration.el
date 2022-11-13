;;; configuration.el ---
;;
;; Filename: configuration.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Wed Nov 12 00:49:28 2014 (+0300)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Вс ноя 13 14:06:43 2022 (+0200)
;;           By: Stanislav M. Ivankin
;;     Update #: 28
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

(setenv "PATH" (concat (getenv "PATH")
                       ":/opt/local/bin"
                       ":/opt/local/sbin"
                       ":~/bin"
                       ":/usr/sbin"))

(when (eq my-system 'osx)
  (setenv "PATH" (concat (getenv "PATH")
                         ":/Applications/Emacs.app/Contents/MacOS/bin/")))

(setq exec-path
      (append exec-path '("/opt/local/bin" "/usr/sbin" "~/bin")))

;; Make gpg2 happy about entering password in minibuffer
(setq epa-pinentry-mode 'loopback)
