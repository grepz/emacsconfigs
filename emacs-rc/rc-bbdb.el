(require 'bbdb)

;;(bbdb-initialize)
(bbdb-initialize 'gnus 'message)
 	
(setq bbdb-north-american-phone-numbers-p nil)
(setq bbdb-user-mail-names
      (regexp-opt '("stas@concat.info"
                    "stas@5070.info"
		    "esgal@iszf.irk.ru")))
(setq bbdb-complete-name-allow-cycling t)
(setq bbdb-use-pop-up nil)
