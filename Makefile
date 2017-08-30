NAME  = rdaslides
SHELL = bash
PWD   = $(shell pwd)
TEMP := $(shell mktemp -d -t tmp.XXXXXXXXXX)
TDIR  = $(TEMP)/$(NAME)
VERS  = $(shell ltxfileinfo -v $(NAME).dtx)
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
all:	$(NAME).pdf $(NAME)-slides.pdf rda-logo.eps clean
	@exit 0
$(NAME).cls $(NAME)-sample-RDA.tex $(NAME)-sample-RDA2016.tex: $(NAME).dtx
	etex -interaction=batchmode $(NAME).dtx >/dev/null
$(NAME)-sample-RDA.pdf: $(NAME)-sample-RDA.tex $(NAME).cls
	latexmk -silent -lualatex -shell-escape -interaction=batchmode $(NAME)-sample-RDA.tex >/dev/null
$(NAME)-sample-RDA2016.pdf: $(NAME)-sample-RDA2016.tex $(NAME).cls
	latexmk -silent -lualatex -shell-escape -interaction=batchmode $(NAME)-sample-RDA2016.tex >/dev/null
$(NAME).pdf: $(NAME).cls $(NAME)-sample-RDA.pdf $(NAME)-sample-RDA2016.pdf
	latexmk -silent -lualatex -shell-escape -interaction=batchmode $(NAME).dtx >/dev/null
$(NAME)-slides.pdf: $(NAME).cls
	latexmk -silent -lualatex -shell-escape -interaction=batchmode -jobname=$(NAME)-slides $(NAME).dtx >/dev/null
rda-logo.eps: rda-logo.pdf
	pdftops -f 1 -l 1 -eps rda-logo.pdf rda-logo.eps
clean:
	rm -f $(NAME).{aux,bbl,bcf,blg,doc,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,listing,log,nav,out,run.xml,snm,synctex.gz,tcbtemp,toc,vrb}
	rm -f $(NAME)-{slides,sample-RDA,sample-RDA2016}.{aux,bbl,bcf,blg,doc,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,ins,listing,log,nav,out,run.xml,snm,synctex.gz,tcbtemp,toc,vrb}
	rm -f rda{mi,mscw,msdw}g.doc
	rm -rf _minted-*
distclean: clean
	rm -f $(NAME).{pdf,ins} $(NAME)-slides.pdf $(NAME).cls rdacolors.sty beamerthemeRDA.sty beamerthemeRDA2016.sty rda{mi,mscw,msdw}g.sty $(NAME)-sample-{RDA,RDA2016}.{tex,pdf}
inst: all
	mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	mkdir -p $(UTREE)/tex/generic/logos-rda
	cp $(NAME).dtx $(NAME).ins $(UTREE)/source/latex/$(NAME)
	cp $(NAME).cls rdacolors.sty beamerthemeRDA.sty beamerthemeRDA2016.sty rda{mi,mscw,msdw}g.sty rda-bg-normal.jpeg rda-bg-title1.jpeg rda-bg-title2.jpeg $(UTREE)/tex/latex/$(NAME)
	cp $(NAME).pdf $(NAME)-sample-{RDA,RDA2016}.{tex,pdf} $(NAME)-slides.pdf README.md $(UTREE)/doc/latex/$(NAME)
	cp rda-logo.{eps,pdf} $(UTREE)/tex/generic/logos-rda
uninst:
	rm -r $(UTREE)/{tex,source,doc}/latex/$(NAME)
	rm $(UTREE)/tex/generic/logos-rda/rda-logo.{eps,pdf}
	rmdir --ignore-fail-on-non-empty $(UTREE)/tex/generic/logos-rda
	mktexlsr
install: all
	sudo mkdir -p $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo mkdir -p $(LOCAL)/tex/generic/logos-rda
	sudo cp $(NAME).dtx $(NAME).ins $(LOCAL)/source/latex/$(NAME)
	sudo cp $(NAME).cls rdacolors.sty beamerthemeRDA.sty beamerthemeRDA2016.sty rda{mi,mscw,msdw}g.sty rda-bg-normal.jpeg rda-bg-title1.jpeg rda-bg-title2.jpeg $(LOCAL)/tex/latex/$(NAME)
	sudo cp $(NAME).pdf $(NAME)-sample-{RDA,RDA2016}.{tex,pdf} $(NAME)-slides.pdf README.md $(LOCAL)/doc/latex/$(NAME)
	sudo cp rda-logo.{eps,pdf} $(LOCAL)/tex/generic/logos-rda
uninstall:
	sudo rm -r $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo rm $(LOCAL)/tex/generic/logos-rda/rda-logo.{eps,pdf}
	sudo rmdir --ignore-fail-on-non-empty $(LOCAL)/tex/generic/logos-rda
	mktexlsr
zip: all
	mkdir $(TDIR)
	cp $(NAME).{pdf,dtx} $(NAME)-slides.pdf $(NAME).cls rdacolors.sty beamerthemeRDA.sty beamerthemeRDA2016.sty rda{mi,mscw,msdw}g.sty $(NAME)-sample-{RDA,RDA2016}.{tex,pdf} README.md Makefile rda-bg-normal.jpeg rda-bg-title1.jpeg rda-bg-title2.jpeg rda-logo.{eps,pdf} $(TDIR)
	cd $(TEMP); zip -Drq $(PWD)/$(NAME)-$(VERS).zip $(NAME)
