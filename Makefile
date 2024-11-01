SHELL := /bin/bash

all: validate_yaml cv.pdf clean

validate_yaml:
	@python -c 'import yaml,sys;yaml.safe_load(sys.stdin)' < cv.yaml

cv:
	echo " " | pandoc --metadata-file cv.yaml --template=template_for_cv.tex -t latex > cv.tex
	pdflatex cv.tex
	rm cv.aux cv.log cv.out cv.tex

clean:
	rm -f cv.aux cv.bcf cv.log cv.out cv.fls *.fdb_latexmk *.synctex.gz

coverletter_%: coverletter_%.md
	pandoc --metadata-file cv.yaml --from=markdown  $@.md --template=template_for_coverletter.tex -t latex > $@.tex
	pdflatex $@.tex
	rm $@.aux $@.log $@.tex $@.out
