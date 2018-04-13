context('gitBusy.R')

library(gitBusy)
library(testthat)

test_that("check if input is in correct format",{
  org <- "UBC-MDS"

  expect_error(org_repos(NULL), "Need to pass in organization name")
  expect_error(org_repos(123), "Organization name must be a string")
  expect_error(org_repos("hakunaaaa matataaaa"), "Organization not found on Github. Please enter a valid organization name must be a valid name")

  expect_error(org_repos(org), "Cannot extract data without authenticating. Please run gtoken <- gh_auth() in the beginning.")
  gtoken <- gh_auth()

})

test_that("Check if output is valid",{
  gtoken <- gh_auth()
  org <- "UBC-MDS"

  expect_that(str(org_repos(org)), prints_text("tbl_df"))

})
