## ----setup, include=FALSE------------------------------------------------
library(knitr)
opts_chunk$set(out.extra='style="display:block; margin: auto"', fig.align="center")

## ----, eval=FALSE--------------------------------------------------------
#  library(devtools)
#  install_github("jmp75/rclr-devtools/packages/rClrDevtools")
#  library(rClrDevtools) # https://github.com/jmp75/rClr-devtools
#  roxyRclr()
#  # roxyRclr(pkgDir='~/src/codeplex/rClr')

## ----, eval=FALSE--------------------------------------------------------
#  library(rClrDevtools) # https://github.com/jmp75/rClr-devtools
#  library(rClr)
#  pkgDir <- tryFindPkgDir()
#  # seem to need to move working directory. Oddities with knitr figure output otherwise
#  originalDir <- getwd()
#  docDir <- file.path(pkgDir, 'inst', 'doc')
#  setwd(docDir)
#  vignettesRclr()

## ----, eval=FALSE--------------------------------------------------------
#  > setwd('c:/src/codeplex/rClr')
#  > tools::buildVignettes(dir='.', tangle=TRUE)
#  Quitting from lines 224-232 (rclr_intro.Rmd)
#  Error: processing vignette 'rclr_intro.Rmd' failed with diagnostics:
#  argument is of length zero

## ----, eval=FALSE--------------------------------------------------------
#  library(rClrDevtools)
#  cpDebugBins()
#  library(testthat)
#  test_package('rClr')

## ----, eval=FALSE--------------------------------------------------------
#  options(warn=2)
#  test_package('rClr')
#  # restore:
#  options(warn=0)

## ----, eval=FALSE--------------------------------------------------------
#  library(rClr)
#  cTypename <- "Rclr.TestCases"
#  testClassName <- "Rclr.TestObject"
#  callGcMethname <- "CallGC"
#  forceDotNetGc <- function() { callTestCase( callGcMethname) }
#  forceGc <- function() {gc() ; forceDotNetGc() ; gc() ; forceDotNetGc() ; }
#  
#  callTestCase <- function(...) {
#    clrCallStatic(cTypename, ...)
#  }
#  
#  blah <- clrCallStatic(cTypename, "CreateArrayMemFootprint", 100L * 1024L * 1024L)
#  forceGc()
#  forceGc()
#  clrCallStatic(cTypename, "SinkLargeObject", blah)
#  forceGc()
#  forceGc()
#  rm(blah)
#  forceGc()
#  forceGc()

