The rdaslides class: Research Data Alliance presentations
=========================================================

The rdaslides LaTeX class is intended to produce slides for Research
Data Alliance (RDA) presentations, or an accompanying transcript, or both.
It is based on the [beamerswitch] class.

Internally, rdaslides uses one of four presentation themes, called ‘RDA’,
‘RDA2016’, ‘RDA2020’ and ‘RDA2024’ respectively, which can be used independently
within beamer.

Installation
------------

### Pre-requisites ###

The documentation uses fonts from the sourceserifpro and sourcesanspro
packages, as well as sourcecodepro if XeLaTeX or LuaLaTeX is used,
or zi4 (inconsolata) otherwise. To compile the documentation
successfully, you will need the minted package installed and working.

### Automated way ###

A makefile is provided which you can use with the Make utility:

  * Running `make rdaslides.cls` generates the derived files:

      - README.md
      - rdaslides.cls
      - rdacolors.sty
      - beamerthemeRDA.sty
      - beamerthemeRDA2016.sty
      - beamerthemeRDA2020.sty
      - beamerthemeRDA2024.sty
      - rdamig.sty
      - rdamscwg.sty
      - rdamsdwg.sty
      - rdaslides.ins
      - rdaslides-sample-RDA.tex
      - rdaslides-sample-RDA2016.tex
      - rdaslides-sample-RDA2020.tex
      - rdaslides-sample-RDA2024.tex

  * Running `make` generates the above plus

      - rda-logo.eps
      - rdaslides.pdf
      - rdaslides-slides.pdf
      - rdaslides-sample-RDA.pdf
      - rdaslides-sample-RDA2016.pdf
      - rdaslides-sample-RDA2020.pdf
      - rdaslides-sample-RDA2024.pdf

  * Running `make inst` installs the files (and images) in the user's
    TeX tree.  (To undo, run `make uninst`.)
  * Running `make install` installs the files (and images) in the
    local TeX tree. (To undo, run `make uninstall`.)

The makefile is set up to use latexmk and lualatex by default.
If this causes difficulty you could change it to use pdflatex directly
instead.

### Manual way ###

To install the class from scratch, follow these instructions. If you have
downloaded the zip file from the [Releases] page on GitHub, you can skip the
first five steps.

 1. Run `etex rdaslides.dtx` to generate the class and package files.

 2. Compile rdaslides-sample-RDA.tex and rdaslides-sample-RDA2016.tex to get
    the example figures used in the documentation.

 3. If you intend to use the theme in DVI mode, you will need to convert the
    logo to EPS format; here is one way to do it:

    ~~~{.bash}
    pdftops -f 1 -l 1 -eps rda-logo.pdf rda-logo.eps
    ~~~

    If you intend to compile the documentation in DVI mode, you will also need
    to transform the output of step 2 to EPS using, say, `dvips` or `pdftops`,
    depending on how you did it.

 4. Compile rdaslides.dtx using your favourite version of LaTeX with shell
    escape enabled (as required by minted for typesetting the listings). You
    will also need to run it through `makeindex`. This will generate the main
    documentation (DVI or PDF).

 5. Compile rdaslides.dtx a second time with `-jobname=rdaslides-slides`
    as a command line option to generate the sample slides. Again, you will
    need to enable shell escape so that minted can mark up the code listings.

 6. Move the files to your TeX tree as follows:

      - `source/latex/rdaslides`:
        rdaslides.dtx,
        rdaslides.ins
      - `tex/generic/logos-rda`:
        rda-logo.eps,
        rda-logo.pdf
      - `tex/latex/rdaslides`:
        rdaslides.cls,
        rdacolors.sty,
        beamerthemeRDA.sty,
        beamerthemeRDA2016.sty,
        beamerthemeRDA2020.sty,
        beamerthemeRDA2024.sty,
        rdamig.sty,
        rdamscwg.sty,
        rdamsdwg.sty,
      - `tex/latex/rdaslides/img2013`:
        rda-bg-normal.jpeg,
        rda-bg-title1.jpeg,
        rda-bg-title2.jpeg
      - `tex/latex/rdaslides/img2020`:
        rda-bg-watermark.jpeg
        rda-link-white.png
        rda-twitter-white.png
      - `tex/latex/rdaslides/img2024`:
        rda24-*.png
      - `doc/latex/rdaslides`:
        rdaslides.pdf,
        rdaslides-sample-RDA.tex,
        rdaslides-sample-RDA.pdf,
        rdaslides-sample-RDA2016.tex,
        rdaslides-sample-RDA2016.pdf,
        rdaslides-sample-RDA2020.tex,
        rdaslides-sample-RDA2020.pdf,
        rdaslides-sample-RDA2024.tex,
        rdaslides-sample-RDA2024.pdf,
        rdaslides-slides.pdf,
        README.md

 7. You may then have to update your installation's file name database
    before TeX and friends can see the files.

Licence
-------

Copyright 2016 Alex Ball.

This work consists of various image files, the documented LaTeX file
rdaslides.dtx, and a Makefile.

The text files contained in this work may be distributed and/or modified
under the conditions of the [LaTeX Project Public License (LPPL)][lppl],
either version 1.3c of this license or (at your option) any later
version.

The rights to the image files distributed with this bundle (except
rda-twitter-white.png) are held by the [Research Data Alliance][rda].
Usage guidelines may be found with the [RDA Communication Kit][rda-kit].

This work is "maintained" (as per LPPL maintenance status) by
[Alex Ball][me].

[beamerswitch]: https://github.com/alex-ball/beamerswitch
[Releases]: https://github.com/alex-ball/rdaslides/releases
[lppl]: http://www.latex-project.org/lppl.txt
[rda]: https://rd-alliance.org/
[rda-kit]: https://www.rd-alliance.org/communication-kit/
[me]: http://alexball.me.uk/

