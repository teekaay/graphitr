#!/usr/bin/env Rscript --vanilla

#
# Install dependencies from a text file. If a dependency
# already exists, it will not be reinstalled.
# The text file is assumed to contain one line per dependency.
# Example:
# --- BEGIN FILE ---
# dplyr
# testthat
# ggplot
# --- END FILE ---
#

kDepsFile <- 'DEPENDENCIES.txt'
kCranMirror <- 'http://cran.us.r-project.org'

depsFileCon <- file(kDepsFile, open = 'r')
deps <- readLines(depsFileCon, skipNul = TRUE, warn = FALSE)

for (i in 1:length(deps)) {
  pkg <- deps[i]
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    install.packages(pkg, repos = kCranMirror)
  }
}

close(depsFileCon)