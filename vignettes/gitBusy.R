## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
suppressPackageStartupMessages(library(httr))
suppressPackageStartupMessages(library(gitBusy))

## ------------------------------------------------------------------------
key <- as.character(Sys.getenv("KEY"))
secret <- as.character(Sys.getenv("SECRET"))
token <- gh_auth(key, secret)

