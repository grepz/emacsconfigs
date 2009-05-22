EMACS=emacs -q --no-site-file

CC     = emacs
CFLAGS = -q --no-site-file -batch -l compile-all.el
ECHO   = echo
Q      ?= @

all:
	$(Q)$(ECHO) "[BLD] Compiling rc files"
	$(CC) $(CFLAGS)

clean:
	find . -name *.elc -exec rm -f '{}' \;
