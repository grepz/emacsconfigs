;; -*- Mode:Emacs-Lisp; coding: utf-8-emacs; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'elmo-split "elmo-split" "Split messages on the folder." t)
(setq elmo-split-folder "%inbox")

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

(setq wl-from "Stanislav M. Ivankin <stas@concat.info>")

(setq wl-fcc "+sent")

(setq wl-icon-directory "~/emacs/etc/wanderlust/icons"
      wl-temporary-file-directory "~/emacs/tmp/wl/tmp"
      wl-score-files-directory    "~/emacs/tmp/wl/elmo")

(setq ;;mime-setup-enable-inline-html t
      mime-edit-split-message nil)

(setq wl-draft-reply-buffer-style 'full)

(setq mime-transfer-level 8
      mime-edit-split-message nil
      mime-edit-message-max-length 32768
      mime-header-accept-quoted-encoded-words t
      mime-browse-url-function 'browse-url-firefox)

;; (set-terminal-coding-system          'utf-8-unix)
;; (set-language-environment            'utf-8)
;; (setq elmo-mime-charset              'utf-8
;;       wl-mime-charset                'utf-8
;;       wl-summary-buffer-mime-charset 'utf-8
;;       default-mime-charset-for-write 'utf-8
;;       default-mime-charset           'utf-8)

;; IMAP
(setq elmo-imap4-use-cache t)
(setq elmo-imap4-default-server "server"
      elmo-imap4-default-user   "user"
      elmo-imap4-default-authenticate-type 'clear)

;; NNTP
(setq wl-nntp-posting-server nil)

;; SMTP
(setq wl-smtp-connection-type nil)
(setq wl-smtp-posting-port 25)
(setq wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user      "stas@concat.info"
      wl-smtp-posting-server    "concat.info"
      wl-local-domain           "concat.info")

(setq elmo-enable-disconnected-operation t)

(setq wl-folder-check-async t
      wl-stay-folder-window t
      wl-draft-truncate-lines t
      wl-draft-use-frame t
      wl-prefetch-threshold nil)

(setq wl-interactive-send t
      wl-interactive-exit nil)

;; Queue
(setq wl-auto-flush-queue t
      wl-draft-enable-queuing nil)

;; Fancy look
(setq wl-thread-have-younger-brother-str "├─"
      wl-thread-youngest-child-str        "└─"
      wl-thread-vertical-str              "│"
      wl-thread-horizontal-str            "─"
      wl-thread-horizontal-str-internal     "+"
      wl-thread-vertical-str-internal       "="
      wl-thread-youngest-child-str-internal "-"
      wl-thread-space-str                   " "
      wl-thread-indent-level 4
      wl-thread-insert-opened t
      wl-summary-divide-thread-when-subject-changed t)

;; Messages
(setq wl-message-ignored-field-list '("^.*")
      wl-message-visible-field-list '("^From:" "^To:" "^Cc:" "^Date:"
				      "^Subject:" "^User-Agent:"
				      "^X-Mailer:" "^Face" "^X-Face")
      wl-message-sort-field-list wl-message-visible-field-list
      wl-message-window-size '(3 . 5)
      wl-message-truncate-lines t)

;; X-Face
;; (when (and window-system
;; 	   (>= emacs-major-version 21))
;;   (autoload 'x-face-decode-message-header "x-face-e21")
;;   (setq wl-highlight-x-face-function 'x-face-decode-message-header))

;; Splitting rules
;; (setq elmo-split-rule
;;       '(((address-equal from "@hh.ru") "%inbox/HeadHunter")
;;      	((address-equal from "@ugu.com") "%inbox/UnixTips")
;; 	((address-equal from "noreply@getafreelancer.com")
;; 	 "%inbox/GetAFreelancer")
;;      	((equal x-ml-name "Haskell") "%inbox/HaskellCafe")
;;      	(t "%inbox")))

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

(setq wl-refile-rule-alist '(("From" ("noreply@getafreelancer.com" .
				      "%inbox/GetAFreelancer"))
			     ("From" ("haskell-cafe-request@haskell.org" .
				      "%inbox/HaskellCafe"))
			     ("From" ("devnull@yandex.ru" . "%inbox/YaRu"))
			     ("List-ID" ("comp.lang.lisp.googlegroups.com" .
					 "%inbox/comp_lang_lisp"))
			     ("List-ID" ("Bug reports for GNU Emacs" .
					 "%inbox/EmacsBugs"))
			     ("List-ID"
			      (".*libssh2-devel.lists.sourceforge.net.*" .
			       "%inbox/libssh"))
			     ("List-ID" ("<weblocks.googlegroups.com>" .
					 "%inbox/weblocks"))
			     ("From" ("lj_notify@livejournal.com" .
				      "%inbox/LiveJournal"))
			     ("From" ("@moikrug.ru" . "%inbox/Moikrug"))
			     ("List-ID" ("<spbhug.googlegroups.com>" .
					 "%inbox/SpbHUG"))
			     ("From" ("listserv@ugu.com" . "%inbox/UnixTips"))
			     ("From" ("no_reply@hh.ru" . "%inbox/HeadHunter"))
			     ("From" ("address" . "%inbox/Family"))
			     ("From" ("address" . "%inbox/Family"))
			     ("From" ("meteo@angara.net" . "%inbox/angara")))
      wl-summary-auto-refile-skip-marks nil)

;; Articles expiring
(setq wl-expire-alist
      '(("^\\+trash$" (date 14) remove)
	("%inbox/\\(libssh\\|weblocks\\|xcb\\|EmacsBugs\\|GetAFreelancer\\|HeadHunter\\)"
	 (date 7) remove)))

;; BBDB
(require 'bbdb-wl)
(bbdb-wl-setup)
(setq signature-use-bbdb t
      wl-summary-from-function 'bbdb-wl-from-func)
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

(wl-generate-user-agent-string-1)
(setq wl-generate-mailer-string-function
      #'(lambda ()
	  (concat "Wanderlust/" wl-version " Emacs/" emacs-version)))

;; Flowed format
;; Reading f=f
(autoload 'fill-flowed "flow-fill")
(add-hook 'mime-display-text/plain-hook
   (lambda () (when (string=
		"flowed" (cdr (assoc "format"
				     (mime-content-type-parameters
				      (mime-entity-content-type entity)))))	
	   (fill-flowed))))

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

(add-hook 'wl-summary-mode-hook 'mc-install-read-mode)
(add-hook 'wl-mail-setup-hook 'mc-install-write-mode)

(defun mc-wl-verify-signature ()
  (interactive)
  (save-window-excursion
    (wl-summary-jump-to-current-message)
    (mc-verify)))

(defun mc-wl-decrypt-message ()
  (interactive)
  (save-window-excursion
    (wl-summary-jump-to-current-message)
    (let ((inhibit-read-only t))
      (mc-decrypt-message))))

(eval-after-load "mailcrypt"
  '(setq mc-modes-alist
         (append
          (quote
           ((wl-draft-mode (encrypt . mc-encrypt-message)
                           (sign . mc-sign-message))
            (wl-summary-mode (decrypt . mc-wl-decrypt-message)
                             (verify . mc-wl-verify-signature))))
          mc-modes-alist)))

(setq mel-b-ccl-module nil
      base64-internal-decoding-limit 0)
