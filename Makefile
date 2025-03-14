NAME  = rdaslides
SHELL = bash
PWD   = $(shell pwd)
TEMP := $(shell mktemp -d -t tmp.XXXXXXXXXX)
TDIR  = $(TEMP)/$(NAME)
VERS  = $(shell ltxfileinfo -v $(NAME).dtx)
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
THEMES= RDA RDA2016 RDA2020 RDA2024
BTHMS = $(THEMES:%=beamertheme%.sty)
STHMS = $(THEMES:%=$(NAME)-sample-%)
GROUPS= rdamig rdamsdwg rdamscwg
AUX   = aux bbl bcf blg doc fdb_latexmk fls glo gls hd idx ilg ind listing log nav out run.xml snm synctex.gz tcbtemp toc vrb
IMG00 = rda-logo.eps rda-logo.pdf rda-logo-notext.png
IMG13 = rda-bg-normal.jpeg rda-bg-title1.jpeg rda-bg-title2.jpeg
IMG20 = rda-bg-wmark.jpeg rda-bullet.png rda-link-white.png rda-twitter-white.png
IMG24 = rda24-body-L1.png rda24-body-L2.png rda24-body-R1.png rda24-body-R2.png rda24-chap-L.png rda24-chap-R.png rda24-finale.png rda24-part-L.png rda24-part-R.png rda24-sect-L.png rda24-sect-R.png rda24-title.png

.PHONY: clean dist-clean inst install uninst uninstall zip

all: $(NAME).pdf $(NAME)-slides.pdf rda-logo.eps clean
	@exit 0

$(NAME).cls rdacolors.sty $(BTHMS) $(STHMS:%=%.tex) $(GROUPS:%=%.sty): $(NAME).dtx
	etex -interaction=batchmode $< >/dev/null

$(NAME)-sample-%.pdf: $(NAME)-sample-%.tex beamertheme%.sty $(NAME).cls
	latexmk -silent -pdflua -shell-escape -interaction=batchmode $< >/dev/null

$(NAME).pdf: $(NAME).dtx $(NAME).cls $(STHMS:%=%.pdf)
	latexmk -silent -pdflua -shell-escape -interaction=batchmode $< >/dev/null

$(NAME)-slides.pdf:$(NAME).dtx $(NAME).cls $(STHMS:%=%.pdf)
	latexmk -silent -pdflua -shell-escape -interaction=batchmode -jobname=$(NAME)-slides $(NAME).dtx >/dev/null

rda-logo.eps: rda-logo.pdf
	pdftops -f 1 -l 1 -eps rda-logo.pdf rda-logo.eps

clean:
	rm -f $(AUX:%=$(NAME).%)
	rm -f $(AUX:%=$(NAME)-slides.%)
	rm -f $(foreach STHM, $(STHMS), $(AUX:%=$(STHM).%))
	rm -f *.minted
	rm -rf _minted*

distclean: clean
	rm -f $(NAME).{pdf,ins} $(NAME)-slides.pdf $(NAME).cls rdacolors.sty $(BTHMS) $(GROUPS:%=%.sty) $(STHMS:%=%.tex) $(STHMS:%=%.pdf)

inst: all
	mkdir -p $(UTREE)/{source,doc,tex}/latex/$(NAME)
	cp $(NAME).dtx $(NAME).ins $(UTREE)/source/latex/$(NAME)
	cp $(NAME).pdf $(NAME)-slides.pdf $(STHMS:%=%.tex) $(STHMS:%=%.pdf) README.md $(UTREE)/doc/latex/$(NAME)
	cp $(NAME).cls rdacolors.sty $(BTHMS) $(GROUPS:%=%.sty) $(UTREE)/tex/latex/$(NAME)
	mkdir -p $(UTREE)/tex/latex/$(NAME)/img{2013,2020,2024}
	cp $(IMG13:%=img2013/%) $(UTREE)/tex/latex/$(NAME)/img2013
	cp $(IMG20:%=img2020/%) $(UTREE)/tex/latex/$(NAME)/img2020
	cp $(IMG24:%=img2024/%) $(UTREE)/tex/latex/$(NAME)/img2024
	mkdir -p $(UTREE)/tex/generic/logos-rda
	cp $(IMG00) $(UTREE)/tex/generic/logos-rda

uninst:
	rm -r $(UTREE)/{tex,source,doc}/latex/$(NAME)
	rm $(IMG00:%=$(UTREE)/tex/generic/logos-rda/%)
	rmdir --ignore-fail-on-non-empty $(UTREE)/tex/generic/logos-rda
	mktexlsr

install: all
	sudo mkdir -p $(LOCAL)/{source,doc,tex}/latex/$(NAME)
	sudo cp $(NAME).dtx $(NAME).ins $(LOCAL)/source/latex/$(NAME)
	sudo cp $(NAME).pdf $(NAME)-slides.pdf $(STHMS:%=%.tex) $(STHMS:%=%.pdf) README.md $(LOCAL)/doc/latex/$(NAME)
	sudo cp $(NAME).cls rdacolors.sty $(BTHMS) $(GROUPS:%=%.sty) $(LOCAL)/tex/latex/$(NAME)
	sudo mkdir -p $(LOCAL)/tex/latex/$(NAME)/img{2013,2020,2024}
	sudo cp $(IMG13:%=img2013/%) $(LOCAL)/tex/latex/$(NAME)/img2013
	sudo cp $(IMG20:%=img2020/%) $(LOCAL)/tex/latex/$(NAME)/img2020
	sudo cp $(IMG24:%=img2024/%) $(LOCAL)/tex/latex/$(NAME)/img2024
	sudo mkdir -p $(LOCAL)/tex/generic/logos-rda
	sudo cp $(IMG00) $(LOCAL)/tex/generic/logos-rda

uninstall:
	sudo rm -r $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo rm $(IMG00:%=$(LOCAL)/tex/generic/logos-rda/%)
	sudo rmdir --ignore-fail-on-non-empty $(LOCAL)/tex/generic/logos-rda
	mktexlsr

zip: all
	mkdir $(TDIR)
	cp $(NAME).{pdf,dtx} $(NAME)-slides.pdf $(NAME).cls rdacolors.sty $(BTHMS) $(GROUPS:%=%.sty) $(STHMS:%=%.tex) $(STHMS:%=%.pdf) README.md Makefile $(IMG00) $(TDIR)
	mkdir -p $(TDIR)/img{2013,2020,2024}
	cp $(IMG13:%=img2013/%) $(TDIR)/img2013
	cp $(IMG20:%=img2020/%) $(TDIR)/img2020
	cp $(IMG24:%=img2024/%) $(TDIR)/img2024
	cd $(TEMP); zip -Drq $(PWD)/$(NAME)-$(VERS).zip $(NAME)
