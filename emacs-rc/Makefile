EMACS=emacs -q --no-site-file

CC     = /Applications/Emacs.app/Contents/MacOS/Emacs
CFLAGS = -q --no-site-file -batch -l compile-all.el
ECHO   = echo
Q      ?= @

all:
	$(Q)$(ECHO) "[BLD] Compiling rc files..."
	$(CC) $(CFLAGS)
	$(Q)$(ECHO) "[BLD] Done."

clean:
	$(Q)$(ECHO) "[CLEAN] Removing elc files..."
	$(Q)find . -name *.elc -exec rm -f '{}' \;
	$(Q)$(ECHO) "[CLEAN] Done."
