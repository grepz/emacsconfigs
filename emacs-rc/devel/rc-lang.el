;;; rc-lang.el ---
;;
;; Filename: rc-lang.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:06:35 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Thu Aug 24 21:49:31 2017 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 73
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


(require 'mode-local)

(setq require-final-newline t)
(defconst use-backup-dir t)

;;
;; CC-Mode
;;

(require 'cwarn)

(setq auto-mode-alist (cons '("\\.h\\'" . c++-mode) auto-mode-alist))

(c-add-style "k&r-2" '("k&r" (intent-tabs-mode . nil) (c-basic-offset . 4)))
(setq c-default-style "k&r-2")

(defun my-c-mode-common-hook ()
  (setq indent-tabs-mode nil)
  (linum-mode 1)
  (c-toggle-auto-hungry-state 1)
  (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
    (ggtags-mode 1))
  (auto-fill-mode 1)
  (fci-mode)
  (cwarn-mode 1)
  (local-set-key [delete] 'delete-char)
  (local-set-key [return] 'newline-and-indent)
  (local-set-key (kbd "s-g") 'gdb-restore-windows)
  (local-set-key "\C-hf" 'woman)
  (local-unset-key (kbd "C-c C-d")))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;
;; Erlang
;;

(require 'erlang)

;; Fixing erlang issues

;; (require 'indy)

;; (setq indy-rules '(
;;     (erlang-mode . (
;;         ((and (indy--current 'indy--starts-with "end")
;;          (indy--prev 'indy--ends-on ") ->"))      (indy--prev-tab))
;;         ((indy--current 'indy--starts-with "end") (indy--prev-tab -1))
;;         ((indy--prev 'indy--ends-on ") ->")       (indy--prev-tab 1))
;;         ((indy--current 'indy--starts-with "]")   (indy--prev-tab -1))
;;         ((indy--prev 'indy--ends-on "[")          (indy--prev-tab 1))
;;         ((indy--prev 'indy--ends-on ",")          (indy--prev-tab))
;;    ))
;; ))

;; (add-to-list 'load-path "~/elisp/distel/elisp/")

;; (require 'distel)
;; (distel-setup)

(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

;; (defun erlang-newline-and-indent ()
;;   (interactive "*")
;;   (delete-horizontal-space t)
;;   (newline nil t)
;;   (indy))

(defun my-erlang-mode-hook ()
  (linum-mode 1)
  (hl-line-mode 1)
  ;; (indy-mode 1)
  (setq erlang-indent-level 4)
  (setq inferior-erlang-machine-options '("-sname" "emacs"))
  ;; add Erlang functions to an imenu menu
  (imenu-add-to-menubar "imenu")
  (fci-mode)
  ;; customize keys
  (local-set-key (kbd "C-h f") 'erlang-man-function))
;;  (local-set-key [return] 'erlang-newline-and-indent))

(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)

;;
;; Lisp
;;

;; Turn on paredit mode when required
;; (autoload 'paredit-mode "paredit" t)

;;(add-to-list 'load-path "/home/grepz/elisp/slime/")

;; Redshank mode

;; (require 'redshank-loader)
;; (eval-after-load "redshank-loader"
;;   '(redshank-setup '(lisp-mode-hook slime-repl-mode-hook) t))

;; (add-hook 'lisp-mode-hook
;;           '(lambda ()
;;              (linum-mode 1)
;;              (hl-line-mode 1)
;;              (fci-mode)
;;              (auto-fill-mode 1)
;;              (local-set-key [delete]  'delete-char)
;;              (local-set-key [return] 'newline-and-indent)
;;              ;;(paredit-mode)
;;              ))

;; (add-hook 'emacs-lisp-mode-hook
;;           '(lambda ()
;;              (linum-mode 1)
;;              (hl-line-mode 1)
;;              (auto-fill-mode 1)
;;              (local-set-key [delete]  'delete-char)
;;              (local-set-key [return] 'newline-and-indent)
;;              (fci-mode)
;;              ;;(paredit-mode)
;;              ))

;; ;; Slime for Lisp

;; (require 'slime-autoloads)

;; (setq slime-repl-history-size 1000
;;       slime-net-coding-system 'utf-8-unix
;;       ;; when nil - truncate lines
;;       slime-truncate-lines nil
;;       inferior-lisp-program "/usr/bin/sbcl"
;;       slime-kill-without-query-p t
;;       slime-contribs '(slime-fancy slime-tramp slime-asdf)
;;       slime-lisp-implementations `((sbcl ("sbcl")
;;                                          :coding-system utf-8-unix)))

;; ;; (eval-after-load "slime"
;; ;;   '(progn
;; ;;      (require 'slime-fuzzy)
;; ;;      (slime-fuzzy-init)
;; ;;      (slime-setup '(slime-fancy slime-asdf slime-tramp))
;; ;;      (paredit-mode)
;; ;;      (redshank-mode)
;; ;; ;;     (add-hook 'slime-mode-hook 'set-up-slime-ac)
;; ;; ;;     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;; ;;      (slime-mode t)
;; ;;      (slime-scratch)
;; ;;      (message "-> slime loaded")))


;; (defun slime-run ()
;;   (interactive)
;;   (slime))

;;(autoload 'slime "slime" t)

;; Display lisp pitfalls on SLIME startup
;;(require 'slime-cl-pitfalls)

;;
;; Scheme
;;

;; (require 'geiser)

;;
;; Perl
;;

(fset 'perl-mode 'cperl-mode)

(custom-set-variables
 '(cperl-tab-always-indent t)
 '(cperl-indent-level 4)
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-invalid-face nil)
 '(cperl-auto-newline t)
 '(cperl-indent-parens-as-block t))

(add-hook 'cperl-mode-hook
          (lambda ()
            (linum-mode 1)
            (hl-line-mode 1)
            (fci-mode)
            (local-set-key (kbd "C-h f") 'cperl-perldoc)
            (local-set-key [return] 'newline-and-indent)
            (linum-mode 1)
            (flymake-mode 1)))

;;
;; Python
;;

(require 'python)

(defun my-python-mode-hook ()
  (setq python-indent-offset 4)
  (fci-mode)
  (hl-line-mode 1)
  (local-set-key [return] 'newline-and-indent)
  (linum-mode 1))

(add-hook 'python-mode-hook 'my-python-mode-hook)

;;
;; Rust
;;

(require 'rust-mode)

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(defun my-rust-mode-hook ()
  (setq indent-tabs-mode nil
        rust-indent-offset 4)
  (fci-mode)
  (hl-line-mode 1)
  (local-set-key [return] 'newline-and-indent)
  (set (make-local-variable 'compile-command) "cargo build")
  (linum-mode 1))

(add-hook 'rust-mode-hook 'my-rust-mode-hook)

;;
;; Sh/Bash
;;

(add-hook 'sh-mode-hook
          '(lambda ()
             (linum-mode 1)
             (fci-mode)))

;;
;; Verilog
;;

(add-hook 'verilog-mode-hook
          '(lambda ()
             (linum-mode 1)
             (hl-line-mode 1)
             (fci-mode)
             (setq-default compilation-error-regexp-alist
                           (mapcar 'cdr verilog-error-regexp-emacs-alist))))

;;
;; Arduino
;;

(setq auto-mode-alist
      (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

(provide 'rc-lang)
;;; rc-lang.el ends here

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-lang.el ends here
