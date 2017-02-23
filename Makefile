# Makefile for automation of the graphitr project.
#
# R Version: 3.2.3 (2015-12-10) Wooden Christmas-Tree
# Operating Systems: Cross-platform

R = Rscript
DOC_DIR = man
PDF_DOC = R2d.pdf

all: deps check tests docs
.PHONY: all

# Install the package
install:
	R CMD INSTALL --no-multiarch --with-keep.source .

# Install all dependencies defined in DEPENDENCIES.txt
deps:
	Rscript install-deps.R

# Generate documentation via roxygen
docs:
	Rscript -e 'roxygen2::roxygenise()'
	R CMD Rd2pdf man

# Run sanity checks
check:
	R CMD check .
	-rm -rf ..Rcheck

# Run all specs in tests/testthat
test:
	Rscript -e 'devtools::test()'

# Clean all generated files
clean:
	rm $(DOC_DIR)/*.Rd
	-rm -rf ..Rcheck
	-rm *.pdf
