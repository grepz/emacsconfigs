;;; -*- Mode: Emacs-Lisp; Coding:utf-8 -*-

(load "~/.emacs")

(setq compile-list
      '("helpers.el"     "rc-autoinsert.el"
	"rc-bbdb.el"     "rc-caml.el"
	"rc-ccmode.el"   "rc-cedet.el"
	"rc-desktop.el"  "rc-devel.el"
	"rc-dired.el"    "rc-ecb.el"
	"rc-erc.el"      "rc-features.el"
	"rc-feel.el"     "rc-haskell.el"
	"rc-headers.el"  "rc-htmlize.el"
	"rc-ide-skel.el" "rc-jabber.el"
	"rc-lisp.el"     "rc-muse.el"
	"rc-music.el"    "rc-net.el"
	"rc-org.el"      "rc-perl.el"
	"rc-theme.el"    "rc-tramp.el"
	"rc-w3m.el"))

(dolist (file compile-list)
  (byte-compile-file file))
