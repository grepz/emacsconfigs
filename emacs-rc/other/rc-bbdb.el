(require 'bbdb)

;;(bbdb-initialize)
(bbdb-initialize 'gnus 'message)

(custom-set-variables
 '(bbdb-north-american-phone-numbers-p nil)
 '(bbdb-user-mail-names
   (regexp-opt '("stas@concat.info"
		 "stas@5070.info"
		 "esgal@iszf.irk.ru")))
 '(bbdb-complete-name-allow-cycling t)
 '(bbdb-use-pop-up nil))
