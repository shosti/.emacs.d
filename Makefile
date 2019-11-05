.PHONY: build clean

build: init.elc

init.elc: init.el
	emacs --batch -l init.el

clean:
	rm -f init.elc && rm -rf elpa && rm -f personal/*.elc
