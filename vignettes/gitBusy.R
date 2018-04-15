## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(httr)
library(gitBusy)

## ------------------------------------------------------------------------
token <- gh_auth(Sys.getenv("KEY"), Sys.getenv("SECRET"))

