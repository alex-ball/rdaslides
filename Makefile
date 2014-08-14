NAME  = rdaslides
SHELL = bash
PWD   = $(shell pwd)
TEMP := $(shell mktemp -d)
TDIR  = $(TEMP)/$(NAME)
VERS  = $(shell ltxfileinfo -v $(NAME).dtx)
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
WORKMF = "/home/ab318/Data/TeX/workmf"
all:	$(NAME).pdf $(NAME)-slides.pdf clean
	test -e README.md && pandoc README.md -t rst -o README || exit 0
$(NAME).pdf: $(NAME).dtx
	latexmk -pdf -silent -pdflatex="lualatex --shell-escape -synctex=1 -interaction=batchmode %O %S" $(NAME).dtx >/dev/null
$(NAME)-slides.pdf: $(NAME).dtx
	latexmk -pdf -silent -pdflatex="lualatex --shell-escape -synctex=1 -interaction=batchmode %O %S" -jobname=$(NAME)-slides $(NAME).dtx >/dev/null
clean:
	rm -f $(NAME).{aux,bbl,bcf,blg,doc,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,ins,listing,log,nav,out,run.xml,snm,synctex.gz,toc,vrb}
	rm -f $(NAME)-slides.{aux,bbl,bcf,blg,doc,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,ins,listing,log,nav,out,run.xml,snm,synctex.gz,toc,vrb}
distclean: clean
	rm -f $(NAME).pdf $(NAME)-slides.pdf $(NAME).cls rdamsdwg.sty README
inst: all
	mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	cp $(NAME).dtx $(UTREE)/source/latex/$(NAME)
	cp $(NAME).cls $(UTREE)/tex/latex/$(NAME)
	cp rdamsdwg.sty  $(UTREE)/tex/latex/$(NAME)
	cp $(NAME).pdf $(UTREE)/doc/latex/$(NAME)
	cp $(NAME)-slides.pdf $(UTREE)/doc/latex/$(NAME)
	cp README $(UTREE)/doc/latex/$(NAME)
install: all
	sudo mkdir -p $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo cp $(NAME).dtx $(LOCAL)/source/latex/$(NAME)
	sudo cp $(NAME).cls $(LOCAL)/tex/latex/$(NAME)
	sudo cp rdamsdwg.sty $(LOCAL)/tex/latex/$(NAME)
	sudo cp $(NAME).pdf $(LOCAL)/doc/latex/$(NAME)
	sudo cp $(NAME)-slides.pdf $(LOCAL)/doc/latex/$(NAME)
	sudo cp README $(LOCAL)/doc/latex/$(NAME)
workmf: all
	sudo mkdir -p $(WORKMF)/{tex,source,doc}/latex/$(NAME)
	sudo cp $(NAME).dtx $(WORKMF)/source/latex/$(NAME)
	sudo cp $(NAME).cls $(WORKMF)/tex/latex/$(NAME)
	sudo cp rdamsdwg.sty $(WORKMF)/tex/latex/$(NAME)
	sudo cp $(NAME).pdf $(WORKMF)/doc/latex/$(NAME)
	sudo cp $(NAME)-slides.pdf $(WORKMF)/doc/latex/$(NAME)
	sudo cp README $(WORKMF)/doc/latex/$(NAME)
zip: all
	mkdir $(TDIR)
	cp $(NAME).{pdf,dtx} $(NAME)-slides.pdf README Makefile $(TDIR)
	cd $(TEMP); zip -Drq $(PWD)/$(NAME)-$(VERS).zip $(NAME)
