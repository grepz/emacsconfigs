;; -*- Mode:Emacs-Lisp; coding: utf-8-emacs; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'elmo-split "elmo-split" "Split messages on the folder." t)
(setq elmo-split-folder "%inbox")

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)


(setq wl-from "Stanislav M. Ivankin <stas@5070.info>")

;;(setq elmo-imap4-default-server "localhost")
;;(setq elmo-imap4-default-user "esgal") 
;;(setq elmo-imap4-default-authenticate-type 'clear) 
;;(setq elmo-imap4-default-stream-type 'ssl)
;;(setq elmo-imap4-use-modified-utf7 t)
(setq elmo-imap4-use-cache t)
(setq elmo-imap4-default-server "localhost"
      elmo-imap4-default-user "esgal"
      elmo-imap4-default-authenticate-type 'clear)

;; IMAP
;;(setq elmo-imap4-default-server "concat.info"
;;      elmo-imap4-default-user "stas@concat.info"
;;      elmo-imap4-default-authenticate-type 'clear
;;      elmo-imap4-default-port '993
;;      elmo-imap4-default-stream-type 'ssl)

(setq elmo-imap4-use-modified-utf7 t)

;; SMTP
;;(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-connection-type nil)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "stas@5070.info"
      wl-smtp-posting-server "smtp.5070.info"
      wl-local-domain "5070.info")

(setq ssl-certificate-verification-policy 1)

(setq wl-folder-check-async t) 

;; NNTP server for news posting. Default: nil
(setq wl-nntp-posting-server nil)

(setq mime-edit-split-message nil)

(setq wl-stay-folder-window t)

(setq wl-message-truncate-lines t)
(setq wl-draft-truncate-lines t)

(setq wl-thread-indent-level 4)
(setq wl-thread-have-younger-brother-str "├─"
     wl-thread-youngest-child-str        "╰─"
     wl-thread-vertical-str              "│"
     wl-thread-horizontal-str            "─"
     wl-thread-space-str                 " ")


(setq elmo-enable-disconnected-operation t)

(setq wl-draft-enable-queuing nil)
(setq wl-auto-flush-queue t)

(setq wl-message-ignored-field-list '("^.*")
      wl-message-visible-field-list '("^From:" "^To:" "^Cc:" "^Date:" "^Subject:" "^User-Agent:" "^X-Mailer:" "^Face" "^X-Face")
      wl-message-sort-field-list wl-message-visible-field-list)


;; Directory where icons are placed.
;; Default: the peculiar value to the running version of Emacs.
;; (Not required if the default value points properly)
(setq wl-icon-directory           "~/emacs/tmp/wl/icons"
      wl-temporary-file-directory "~/emacs/tmp/wl/tmp"
      wl-score-files-directory    "~/emacs/tmp/wl/elmo")

(setq wl-prefetch-threshold 500000)
(setq wl-message-window-size '(3 . 5))

(setq elmo-split-rule
      '(((address-equal from "@hh.ru") "%inbox/HeadHunter")
     	((address-equal from "@ugu.com") "%inbox/UnixTips")
	((address-equal from "noreply@getafreelancer.com") "%inbox/GetAFreelancer")
     	((equal x-ml-name "Haskell") "%inbox/HaskellCafe")
     	(t "%inbox")))

(setq elmo-msgdb-extra-fields
'("newsgroups"
"list-id" "x-ml-name" "mailing-list"
"x-mail-count" "x-ml-count" "x-sequence"))

(setq elmo-msgdb-extra-fields
      '("x-ml-name"
	"reply-to"
	"sender"
	"mailing-list"
	"newsgroups"
	"list-id"
	"x-mail-count"
	"x-ml-count"
	"x-sequence"))

(setq wl-refile-rule-alist '(("From" ("noreply@getafreelancer.com" . "%inbox/GetAFreelancer"))
			     ("From" ("haskell-cafe-request@haskell.org" . "%inbox/HaskellCafe"))
			     ("From" ("devnull@yandex.ru" . "%inbox/YaRu"))
			     ("List-ID" ("comp.lang.lisp.googlegroups.com" . "%inbox/comp_lang_lisp"))
			     ("List-ID" ("Bug reports for GNU Emacs" . "%inbox/EmacsBugs"))
			     ("List-ID" (".*libssh2-devel.lists.sourceforge.net.*" . "%inbox/libssh"))
			     ("List-ID" ("<weblocks.googlegroups.com>" . "%inbox/weblocks"))
			     ("From" ("lj_notify@livejournal.com" . "%inbox/LiveJournal"))
			     ("List-ID" ("xcb.lists.freedesktop.org" . "%inbox/xcb"))
			     ("From" ("@moikrug.ru" . "%inbox/Moikrug"))
			     ("List-ID" ("<spbhug.googlegroups.com>" . "%inbox/SpbHUG"))
			     ("From" ("listserv@ugu.com" . "%inbox/UnixTips")))
      wl-summary-auto-refile-skip-marks nil)

(setq wl-icon-directory "~/emacs/etc/wanderlust/icons")

;;(setq mime-setup-enable-inline-html t)

(setq wl-fcc "%inbox/sent")
;; Confirm when sending draft
(setq wl-interactive-send t)
;; Do not ask me when quit
(setq wl-interactive-exit nil)

(require 'bbdb-wl)
(bbdb-wl-setup)
;; enable pop-ups
;;(setq bbdb-use-pop-up t)
(setq signature-use-bbdb t)
;; shows the name of bbdb in the summary :-)
(setq wl-summary-from-function 'bbdb-wl-from-func)

;; automatically add mailing list fields
;(add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)
;(setq bbdb-auto-notes-alist '(("X-ML-Name" (".*$" ML 0))))

(add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)

(setq bbdb-auto-notes-alist
      '(("Organization" (".*" company 0))
	("X-URL" (".*" www 0))
	("X-URI" (".*" www 0))
	("User-Agent" (".*" mailer 0))
	("X-Mailer" (".*" mailer 0))
	("X-Newsreader" (".*" mailer 0))
	("Subject" (".*" last-subj 0 'replace))
	("X-Face" (".+" face 0 'replace))
	("Face" (".+" cface 0 'replace))))

;;(setq wl-folder-window-width 25)
;;(setq wl-summary-width 140)

;;(setq my-wl-summary-from-outgoing-folder-list '("+sent" "%inbox/sent"))

(setq wl-thread-insert-opened t)
(setq wl-stay-folder-window t)
(setq wl-draft-use-frame t)

(setq wl-summary-divide-thread-when-subject-changed t)

;(setq elmo-archive-use-cache nil)
;(setq elmo-nntp-use-cache t)
;(setq elmo-imap4-use-cache t)
;(setq elmo-pop3-use-cache t)

(setq elmo-enable-disconnected-operation t)

(setq wl-draft-enable-queuing t)
(setq wl-auto-flush-queue t)

;(add-hook 'wl-summary-mode-hook
; '(lambda ()
; (define-key wl-summary-mode-map "b" 'wl-summary-resend-message)
; ))

(wl-generate-user-agent-string-1)

(setq wl-generate-mailer-string-function
      #'(lambda ()
	  (concat "Wanderlust/" wl-version " Emacs/" emacs-version)))

(setq wl-template-alist
      '(("default"
	 ("From" . wl-from)
;;	 ("Organization" . "")
	 (body . "Hello."))))

(setq wl-draft-reply-buffer-style 'full)

;; (set-language-environment "UTF-8") ; Default would be utf8
;; (setq default-mime-charset-for-write 'utf-8)
;; (setq default-mime-charset 'utf-8)

;; Flowed format
;; Reading f=f
(autoload 'fill-flowed "flow-fill")
(add-hook 'mime-display-text/plain-hook
	  (lambda ()
	    (when (string= "flowed"
			   (cdr (assoc "format"
				       (mime-content-type-parameters
					(mime-entity-content-type entity)))))
	      (fill-flowed))))


;; Articles expiring
(setq wl-expire-alist
      '(("^\\+trash$" (date 14) remove)
	("%inbox/\\(libssh\\|weblocks\\|xcb\\)" (date 7) remove)))


(when (and window-system
	   (>= emacs-major-version 21))
  (autoload 'x-face-decode-message-header "x-face-e21")
  (setq wl-highlight-x-face-function 'x-face-decode-message-header))

;; Mail encryption

(autoload 'wl-summary-decrypt-pgp-nonmime "wl-pgp-nonmime"
  "Decrypt PGP encrypted region" t)
(autoload 'wl-summary-verify-pgp-nonmime "wl-pgp-nonmime"
  "Verify PGP signed region" t)
(autoload 'wl-summary-pgp-snarf-keys-nonmime "wl-pgp-nonmime"
  "Extract PGP keys" t)

(define-key wl-summary-mode-map "\C-c/v" 'wl-summary-verify-pgp-nonmime)
(define-key wl-summary-mode-map "\C-c/d" 'wl-summary-decrypt-pgp-nonmime)
(define-key wl-summary-mode-map "\C-c/a" 'wl-summary-pgp-snarf-keys-nonmime)
