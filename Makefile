# Makefile for automation of the graphitr project.
#
# R Version: 3.2.3 (2015-12-10) Wooden Christmas-Tree
# Operating Systems: Cross-platform

R = Rscript
DOC_DIR = man
PDF_DOC = R2d.pdf

all: deps check tests docs 
.PHONY: all

# Install all dependencies defined in DEPENDENCIES.txt
deps:
	$(R) install-deps.R

# Run all specs in tests/
tests:
	$(R) -e 'testthat::test_dir(".")'


# Generate documentation via roxygen
docs:
	$(R) -e 'roxygen2::roxygenise()'
	$(R) CMD Rd2pdf man

# Run sanity checks
check:
	$(R) CMD check .

# Clean all generated files
clean:
	rm $(DOC_DIR)/*.Rd
	-rm -rf ..Rcheck
	-rm *.pdf
