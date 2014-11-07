(require 'desktop)

(desktop-save-mode 1)

(setq desktop-dirname "~/emacs/tmp/desktop"
	  desktop-path "~/emacs/tmp/desktop")

(mapc
 (lambda (symbol)
   (add-to-list 'desktop-globals-to-save symbol))
 '((buffer-name-history      . 100)
   (undo-limit               . 500000)
   (dired-regexp-history     . 20)
   (extended-command-history . 100)
   (file-name-history        . 500)
   (grep-history             . 50)
   (minibuffer-history       . 100)
   (query-replace-history    . 60)
   (read-expression-history  . 60)
   (regexp-history           . 60)
   (regexp-search-ring       . 20)
   (search-ring              . 20)
   (shell-command-history    . 50)))

(mapc
 (lambda (symbol)
   (add-to-list 'desktop-locals-to-save symbol))
 '(buffer-file-coding-system
   tab-width))

(setq-default desktop-missing-file-warning nil
			  desktop-path '("~/emacs/tmp/desktop")
			  desktop-save t
			  desktop-save-mode t
			  save-place t)
