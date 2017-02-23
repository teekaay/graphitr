# Makefile for automation of the graphitr project.
#
# R Version: 3.2.3 (2015-12-10) Wooden Christmas-Tree
# Operating Systems: Cross-platform

R = Rscript

# Install all dependencies defined in DEPENDENCIES.txt
deps:
	$(R) install-deps.R

# Run all specs in tests/
tests:
	$(R) -e 'testthat::test_dir(".")'


# Generate documentation via roxygen
docs:
	$(R) -e 'roxygen2::roxygenise()'
