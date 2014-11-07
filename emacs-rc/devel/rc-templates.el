;;; rc-templates.el ---
;;
;; Filename: rc-templates.el
;; Description:
;; Author: Stanislav M. Ivankin
;; Maintainer:
;; Created: Sat Nov  8 02:07:33 2014 (+0800)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sat Nov  8 02:07:41 2014 (+0800)
;;           By: Stanislav M. Ivankin
;;     Update #: 2
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


(require 'autoinsert)

(auto-insert-mode 1)

(eval-after-load 'autoinsert
  '(progn
     (define-auto-insert
       '("main\\.c\\'" . "C main skeleton")
       '("Description: "
		 "/**\n"
		 " * Filename " (file-name-nondirectory (buffer-file-name)) "\n"
		 " * Description: " str "\n"
		 " * Created on " (format-time-string "%Y-%m-%d <%H:%M:%S>") "\n"
		 " **/" "\n\n"
		 "#include <stdlib.h>" "\n"
		 "#include <stdio.h>"  "\n"
		 "#include <stdint.h>" "\n\n"
		 "int main(int argc, char *argv[])\n"
		 "{" "\n"
		 > _ "\n"
		 "}" "\n"))
     (define-auto-insert
       '("main\\.\\(cc\\|cxx\\|cpp\\|c++\\)\\'" . "C++ main skeleton")
       '("Description: "
		 "/*" "\n"
		 " * " (file-name-nondirectory (buffer-file-name))
		 " -- " str "\n"
		 " */" "\n\n"
		 "#include <iostream>"  "\n\n"
		 "using namespace std;" "\n\n"
		 "int main(int argc, char *argv[])" "\n"
		 "{" "\n"
		 > _ "\n"
		 "}" "\n"))
     (define-auto-insert
       '("\\.py\\'" . "Python file skeleton")
       '("Description: "
		 "#!/usr/bin/env python"   "\n"
		 "# -*- coding: utf-8 -*-" "\n"
		 "# Description: " str     "\n"
		 "# Created on " (format-time-string "%Y-%m-%d <%H:%M:%S>") "\n"
		 "#" "\n\n"
		 "\"\"\" TODO: Docstring\"\"\"" "\n\n"))))

(provide 'rc-templates)
;;; rc-templates.el ends here

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-templates.el ends here
