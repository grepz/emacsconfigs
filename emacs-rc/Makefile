EMACS=emacs -q --no-site-file

all:
	@$(EMACS) -batch -l compile-all.el

clean:
	find . -name *.elc -exec rm -f '{}' \;
