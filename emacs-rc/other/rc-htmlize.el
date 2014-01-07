;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [14.40:50 Январь 07 2014]
;; Modified: [14.40:51 Январь 07 2014]
;;  ---------------------------
;; Author: Stanislav M. Ivankin
;; Email: lessgrep@gmail.com
;; Tags: elisp,emacs,html
;; License: GPLv3
;;  ---------------------------
;; Description:

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
