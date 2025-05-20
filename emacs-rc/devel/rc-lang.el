;;; rc-lang.el ---
;;
;; Filename: rc-lang.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:06:35 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Ср авг  7 12:22:30 2024 (+0300)
;;           By: Stanislav M. Ivankin
;;     Update #: 260
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

(use-package cwarn
  :ensure)

(use-package ggtags
  :ensure)

(setq auto-mode-alist (cons '("\\.h\\'" . c++-mode) auto-mode-alist))

(c-add-style "k&r-2" '("k&r" (intent-tabs-mode . nil) (c-basic-offset . 4)))
(setq c-default-style "k&r-2")

(defun my-c-mode-common-hook ()
  (setq indent-tabs-mode nil)
  (c-toggle-auto-hungry-state 1)
  ;; (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
  ;;   (ggtags-mode 1))
  (auto-fill-mode 1)
  (cwarn-mode 1)
  (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
    (ggtags-mode 1))
  (local-set-key [delete] 'delete-char)
  (local-set-key [return] 'newline-and-indent)
  (local-set-key (kbd "s-g") 'gdb-restore-windows)
  (local-set-key "\C-hf" 'woman)
  (local-unset-key (kbd "C-c C-d")))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;
;; Erlang
;;


(defun my-erlang-mode-hook ()
  (hl-line-mode 1)
  (setq erlang-indent-level 4)
  (setq inferior-erlang-machine-options '("-sname" "emacs"))
  ;; add Erlang functions to an imenu menu
  (imenu-add-to-menubar "imenu")
  ;; customize keys
  (local-set-key (kbd "C-h f") 'erlang-man-function))


(use-package erlang
  :ensure
  :config
  (add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
  (add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))
  (add-hook 'erlang-mode-hook 'my-erlang-mode-hook))

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
;;              (hl-line-mode 1)
;;              (auto-fill-mode 1)
;;              (local-set-key [delete]  'delete-char)
;;              (local-set-key [return] 'newline-and-indent)
;;              ;;(paredit-mode)
;;              ))

(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (hl-line-mode 1)
             (auto-fill-mode 1)
             (local-set-key [delete]  'delete-char)
             (local-set-key [return] 'newline-and-indent)
             ;;(paredit-mode)
             ))

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
;; scheme
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
            (hl-line-mode 1)
            (local-set-key (kbd "C-h f") 'cperl-perldoc)
            (local-set-key [return] 'newline-and-indent)
            (flymake-mode 1)))

;;
;; python
;;

(require 'python)

(defun my-python-mode-hook ()
  (setq python-indent-offset 4)
  (hl-line-mode 1)
  (local-set-key [return] 'newline-and-indent))

(add-hook 'python-mode-hook 'my-python-mode-hook)

;;
;; Rust
;;

;; (require 'rust-mode)
(use-package rust-playground :ensure)
(use-package toml-mode :ensure)
(use-package bind-key :ensure)

;; (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; (defun my-rust-mode-hook ()
;;   (setq indent-tabs-mode nil
;;         rust-indent-offset 4)
;;   (hl-line-mode 1)
;;   (local-set-key [return] 'newline-and-indent)
;;   (set (make-local-variable 'compile-command) "cargo build"))

;; (add-hook 'rust-mode-hook 'my-rust-mode-hook)

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (setf lsp-rust-analyzer-cargo-watch-command "clippy"
        lsp-eldoc-render-all t
        lsp-idle-delay 3
        ;; enable / disable the hints as you prefer:
        lsp-rust-analyzer-server-display-inlay-hints nil
        lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial"
        lsp-rust-analyzer-display-chaining-hints t
        lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil
        lsp-rust-analyzer-display-closure-return-type-hints t
        lsp-rust-analyzer-display-parameter-hints t
        lsp-rust-analyzer-display-reborrow-hints "always"
        lsp-diagnostics-provider :auto
        lsp-lens-enable nil
        lsp-eldoc-enable-hover t) ;; nil
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-show-code-actions nil)
  (lsp-ui-peek-always-show nil)
  (lsp-ui-sideline-delay 3) ;; delay hover hints
  (lsp-ui-sideline-show-hover t) ;; hover hints on flycheck/flymake
  (lsp-ui-doc-enable t)
  (lsp-headerline-breadcrumb-enable t))

(use-package company
  :ensure
  :custom
  (company-idle-delay 3) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last)))

(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  (setf eldoc-documentation-functions nil
        lsp-enable-snippet t ;; nil
        lsp-inlay-hint-enable nil
        lsp-enable-symbol-highlighting t ;; nil
        lsp-signature-auto-activate nil
        eglot-send-changes-idle-time (* 60 60)
        rustic-lsp-client 'lsp-mode
        rustic-format-on-save nil
        lsp-flycheck-live-reporting nil
        flycheck-idle-change-delay 3)

  ;; comment to disable rustfmt on save
  ;; (setq rustic-format-on-save t)
  (remove-hook 'rustic-mode-hook 'flycheck-mode)
  (add-hook 'eglot--managed-mode-hook
            (lambda ()
              (flymake-mode -1)))
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))

;;
;; Sh/Bash
;;

;; (add-hook 'sh-mode-hook
;;           '(lambda ()
;;              (fci-mode)))

;;
;; Verilog
;;


(use-package verilog-mode
  :mode "\\.\\(v|verilog|vig\\)$"
  :config
  (add-hook 'verilog-mode-hook
            '(lambda ()
               (hl-line-mode 1)
               (setq-default compilation-error-regexp-alist
                             (mapcar 'cdr verilog-ert1ror-regexp-emacs-alist)))))
;;
;; Arduino
;;

(use-package arduino-mode
  :ensure
  :mode "\\.\\(pde\\|ino\\)$")
;;
;; Elixir
;;

(use-package elixir-mode
  :ensure
  :mode "\\.\\(ex\\|exs\\)$"
  :config
  (add-hook 'elixir-mode-hook '(lambda () (hl-line-mode 1))))

;; (add-to-list 'auto-mode-alist '("\\.\\(ex\\|exs\\)$'" . elixir-mode))

;; (add-to-list 'elixir-mode-hook
;;              '(lambda ()
;;                 (hl-line-mode 1)))

;;
;; PlantUML
;;

(use-package plantuml-mode
  :ensure
  :mode "\\.puml$"
  :custom
  ;; Sample executable configuration
  (plantuml-executable-path "/usr/bin/plantuml")
  (plantuml-default-exec-mode 'executable))

;;
;; Zig
;;

(use-package zig-mode
  :ensure
  :mode "\\.zig$")

(provide 'rc-lang)
;;; rc-lang.el ends here

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-lang.el ends here
