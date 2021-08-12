UNAME := $(shell uname -s)

SYN := /syntax
FT := /ftdetect

ifeq ($(OS), Windows_NT)
	ROOT := $(HOME)/vimfiles
else
	ifeq ($(UNAME), Haiku)
		ROOT := /boot/home/config/settings/vim
	else
		ROOT := ~/.vim
	endif
endif

.PHONY: install
install: ./syntax/gmi.vim ./ftdetect/gmi.vim
	install -d ${ROOT}${SYN}
	install -d ${ROOT}${FT}
	install -m 0644 .${SYN}/gmi.vim ${ROOT}${SYN}
	install -m 0644 .${FT}/gmi.vim ${ROOT}${FT}

.PHONY: remove
remove:
	rm -rf ${ROOT}${SYN}/gmi.vim
	rm -rf ${ROOT}${FT}/gmi.vim
