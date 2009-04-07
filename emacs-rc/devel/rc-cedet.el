;; Elisp source code header -*- coding: utf-8 -*-
;; Created: [16-06:15 Июль 19 2008]
;; Modified: [10.41:18 Апрель 07 2009]
;; Description: 
;; Author: Stanislav M. Ivankin
;; Email: stas@concat.info
;; Tags: 
;; License: 

;;; Code:

(add-to-list 'load-path "~/elisp/cedet")
;;(setq semantic-load-turn-everything-on t)
(load-file "~/elisp/cedet/common/cedet.el")

;; (require 'bovine-grammar nil t)
(when (require 'ede nil t)
  (global-ede-mode t)
  (message "Ede switched ON"))

(require 'semantic nil t)
;; ;(semantic-load-enable-code-helpers)
;; ;(global-semantic-idle-scheduler-mode 1)
;; ;(global-semantic-idle-completions-mode 1)
;; ;(global-semantic-idle-summary-mode 1)
(require 'semantic-sb nil t)
(require 'semanticdb nil t)

(semantic-load-enable-gaudy-code-helpers)

;; smart complitions
(require 'semantic-ia)

(global-semanticdb-minor-mode 1)

(setq-mode-local c-mode semanticdb-find-default-throttle
		 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                  '(project unloaded system recursive))

(require 'eassist)

;; customisation of modes
(defun my-cedet-hook ()
; (local-set-key "\C-c/" 'semantic-ia-complete-symbol)
  (local-set-key "\C-cc" 'semantic-ia-complete-symbol)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-ch" 'eassist-switch-h-cpp))

(add-hook 'c-mode-common-hook 'my-cedet-hook)

(setq-default semanticdb-default-save-directory
	      "~/emacs/tmp/semanticdb/"
	      semanticdb-default-system-save-directory
	      "~/emacs/tmp/semanticdb/")

(semantic-add-system-include "/usr/include" 'c-mode)
(semantic-add-system-include "/usr/include" 'c++-mode)
(semantic-add-system-include "/usr/include/c++/4.2" 'c++-mode)
(semantic-add-system-include "/usr/local/include" 'c-mode)
(semantic-add-system-include "/usr/local/include" 'c++-mode)

(custom-set-variables
 '(semantic-idle-scheduler-idle-time 3))

(global-semantic-stickyfunc-mode -1)

(global-semantic-folding-mode 1)
(global-semantic-tag-folding-mode 1)

;;;;;

(require 'ede-ext)

(defvar ede-default-kvm-buffer "*KVM buffer*")

;; Thanks to Alex Ott for ede-compile idea
(defun ede-get-local-var (fname var)
  (let* ((current-dir (file-name-directory fname))
         (prj (ede-current-project current-dir)))
    (when prj
      (let* ((ov (oref prj local-variables))
            (lst (assoc var ov)))
        (when lst
          (cdr lst))))))

(defun ede-compile ()
  (interactive)
  (save-some-buffers t)
  (compile (or (ede-get-local-var
                (buffer-file-name (current-buffer)) 'compile-command)
               compile-command) t))

(defun ede-clean ()
  (interactive)
  (let ((clean-cmd (ede-get-local-var
		    (buffer-file-name (current-buffer)) 'clean-command)))
    (when clean-cmd
      (compile clean-cmd))))

(defun* ede-kvm-run (&optional image kvm-buffer)
  (interactive)
  (let* ((fname (buffer-file-name (current-buffer)))
	 (buffer (unless kvm-buffer
		   (or (ede-get-local-var fname 'kvm-buffer)
		       ede-default-kvm-buffer)))
	 (img (or image (ede-get-local-var fname 'kvm-image))))
    (when (or (null buffer) (null img))
      (message "Some parameters wasn't set correctly (%s:%s)" buffer img)
      (return-from ede-kvm-run 1))
    (message "Starting KVM on buffer %s with image %s" buffer img)
    (start-process "ede-kvm" buffer "kvm"
		   "-smp" "2"
		   "-serial" "/dev/stdout" img)
    (switch-to-buffer buffer)))

(defun ede-style-hook ()
  (let* ((dir (file-name-directory
	       (buffer-file-name (current-buffer))))
	 (proj (ede-current-project dir)))
    (when (and proj (ede-cpp-root-project-ext-p proj))
      (c-set-style (ede-project-coding-style proj) nil))))

(ede-cpp-root-project-ext
 "JariOSservers"
 :name "Jari OS Core servers"
 :file "~/Projects/jarios/core_servers/Makefile"
 :include-path '("/include")
 :coding-style "gnu"
 :system-include-path
 '("~/Projects/jarios/syslibs/general/include")
 :local-variables
 '((compile-command . "cd /home/esgal/Projects/jarios/core_servers && \
 sudo make -j2 install && sudo make install_image && sudo sync")
   (clean-command . "cd /home/esgal/Projects/jarios/core_servers; make clean")
   (kvm-image . "/home/esgal/Projects/jarios/boot.img")
   (kvm-buffer . "*JariOS KVM buffer*")))

(ede-cpp-root-project-ext
 "JariOSsyslibs"
 :name "Jari OS syslibs"
 :file "~/Projects/jarios/syslibs/README"
 :include-path '("/general/include")
 :coding-style "gnu"
 :system-include-path
 '("/usr/include")
 :local-variables
 '((compile-command . "cd /home/esgal/Projects/jarios/core_servers && \
 sudo make -j2 install && sudo make install_image && sudo sync")
   (clean-command . "cd /home/esgal/Projects/jarios/syslibs; make clean")
   (kvm-image . "/home/esgal/Projects/jarios/boot.img")
   (kvm-buffer . "*JariOS KVM buffer*")))

(ede-cpp-root-project-ext
 "JariOSkernel"
 :name "Jari OS kernel"
 :file "~/Projects/jarios/muistring/Makefile"
 :include-path '("/include/")
 :coding-style "gnu"
 :system-include-path nil
 :local-variables
 '((compile-command . "cd /home/esgal/Projects/jarios/muistring && \
make -j2 vmuielf && sudo cp ./vmuielf ../mnt/boot && sudo sync")
   (clean-command . "cd /home/esgal/Projects/jarios/muistring && make clean")
   (kvm-image . "/home/esgal/Projects/jarios/boot.img")
   (kvm-buffer . "*JariOS KVM buffer*")))

(add-hook 'c-mode-common-hook 'ede-style-hook)
(global-set-key (kbd "C-x m") 'ede-compile)
(global-set-key (kbd "C-x n") 'ede-clean)
(global-set-key (kbd "C-c k") 'ede-kvm-run)
