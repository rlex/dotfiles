SCRIPT=plugin/SudoEdit.vim autoload/SudoEdit.vim
DOC=doc/SudoEdit.txt
PLUGIN=SudoEdit
VERSION=$(shell sed -n '/Version:/{s/^.*\(\S\.\S\+\)$$/\1/;p}' plugin/SudoEdit.vim)

.PHONY: $(PLUGIN).vmb clean

all: $(PLUGIN).vmb install

vimball: $(PLUGIN) $(PLUGIN).vmb

version: $(PLUGIN) $(PLUGIN).vmb

clean:
	rm -rf *.vmb *.vba */*.orig *.~* .VimballRecord doc/tags
	find . -type f \( -name "*.vba" -o -name "*.orig" -o -name "*.~*" \
	-o -name ".VimballRecord" -o -name ".*.un~" -o -name "*.sw*" -o \
	-name tags -o -name "*.vmb" \) -delete

dist-clean: clean

install:
	vim -N -u NONE -c 'ru! plugin/vimballPlugin.vim' -c':so %' -c':q!' ${PLUGIN}.vmb

release: $(PLUGIN) $(PLUGIN).vmb
	ln -f $(PLUGIN).vmb $(PLUGIN)-$(VERSION).vmb
	cp -f $(DOC) README

uninstall:
	vim -N -u NONE -c 'ru! plugin/vimballPlugin.vim' -c':RmVimball ${PLUGIN}.vmb'

undo:
	for i in */*.orig; do mv -f "$$i" "$${i%.*}"; done

test:
	( cd test; ./test.sh )

SudoEdit.vmb:
	rm -f $(PLUGIN).vmb
	vim -N -u NONE -c 'ru! plugin/vimballPlugin.vim' -c ':let g:vimball_home=getcwd()'  -c ':call append("0", ["autoload/SudoEdit.vim", "doc/SudoEdit.txt", "plugin/SudoEdit.vim", "autoload/sudo.cmd", "autoload/SudoEdit.vbs"])' -c '$$d' -c ':%MkVimball ${PLUGIN}' -c':q!'
	vim -N -u NONE -c 'ru! vimballPlugin.vim' -c ':so %' -c':q!' ${PLUGIN}.vmb

SudoEdit:
	perl -i.orig -pne 'if (/Version:/) {s/\.(\d*)/sprintf(".%d", 1+$$1)/e}' ${SCRIPT}
	perl -i -pne 'if (/GetLatestVimScripts:/) {s/(\d+)\s+:AutoInstall:/sprintf("%d :AutoInstall:", 1+$$1)/e}' ${SCRIPT}
	perl -i -pne 'if (/Last Change:/) {s/(:\s+).*\n/sprintf(": %s", `date -R`)/e}' ${SCRIPT}
	perl -i.orig -pne 'if (/Version:/) {s/\.(\d+).*\n/sprintf(".%d %s", 1+$$1, `date -R`)/e}' ${DOC}

