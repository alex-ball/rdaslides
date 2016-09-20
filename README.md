The rdaslides class: Research Data Alliance presentations
=========================================================

The rdaslides LaTeX class is intended to produce slides for Research
Data Alliance (RDA) presentations, or an accompanying transcript, or both.
It is based on the [beamerswitch] class.

Internally, rdaslides uses one of two presentation themes, called 'RDA'
and 'RDA2016' respectively, which can be used independently within beamer.

Installation
------------

### Pre-requisites ###

The documentation uses fonts from the XCharter and sourcesanspro
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
      - rdamscwg.sty
      - rdamsdwg.sty
      - rdaslides.ins
      - rdaslides-sample-RDA.tex
      - rdaslides-sample-RDA2016.tex

  * Running `make` generates the above plus

      - rdaslides.pdf
      - rdaslides-slides.pdf
      - rdaslides-sample-RDA.pdf
      - rdaslides-sample-RDA2016.pdf

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
first four steps.

 1. Run `etex rdaslides.dtx` to generate the class and package files.

 2. Compile rdaslides-sample-RDA.tex and rdaslides-sample-RDA2016.tex to get
    the example figures used in the documentation.

 3. Compile rdaslides.dtx using your favourite version of LaTeX with shell
    escape enabled (as required by minted for typesetting the listings). You
    will also need to run it through `makeindex`. This will generate the main
    documentation (DVI or PDF).

 4. Compile rdaslides.dtx a second time with `-jobname=rdaslides-slides`
    as a command line option to generate the sample slides. Again, you will
    need to enable shell escape so that minted can mark up the code listings.

 5. Move the files to your TeX tree as follows:

      - `source/latex/rdaslides`:
        rdaslides.dtx,
        rdaslides.ins
      - `tex/latex/rdaslides`:
        rdaslides.cls,
        rdacolors.sty,
        beamerthemeRDA.sty,
        beamerthemeRDA2016.sty,
        rdamscwg.sty,
        rdamsdwg.sty,
        rda-bg-normal.jpeg,
        rda-bg-title1.jpeg,
        rda-bg-title2.jpeg
      - `doc/latex/rdaslides`:
        rdaslides.pdf,
        rdaslides-sample-RDA.tex,
        rdaslides-sample-RDA.pdf,
        rdaslides-sample-RDA2016.tex,
        rdaslides-sample-RDA2016.pdf,
        rdaslides-slides.pdf,
        README.md

 6. You may then have to update your installation's file name database
    before TeX and friends can see the files.

Licence
-------

Copyright 2016 Alex Ball.

This work consists of four image files (rda-logo.pdf, rda-bg-normal.jpeg,
rda-bg-title1.jpeg, and rda-bg-title2.jpeg), the documented LaTeX file
rdaslides.dtx, and a Makefile.

The text files contained in this work may be distributed and/or modified
under the conditions of the [LaTeX Project Public License (LPPL)][lppl],
either version 1.3c of this license or (at your option) any later
version.

The rights to the image files distributed with this bundle are held by
the [Research Data Alliance][rda].

This work is "maintained" (as per LPPL maintenance status) by
[Alex Ball][me].

[beamerswitch]: https://github.com/alex-ball/beamerswitch
[Releases]: https://github.com/alex-ball/rdaslides/releases
[lppl]: http://www.latex-project.org/lppl.txt
[rda]: https://rd-alliance.org/
[me]: http://alexball.me.uk/

