context('gitBusy.R')
library(gitBusy)
library(testthat)
library(stringr)

# Same test functions for both Org_repos and Org_members
test_that("check if input is in correct format",{
  org <- "UBC-MDS"

  expect_error(organization_members(NULL), "Organization input needs to be a string")
  expect_error(organization_members(1234), "Organization input needs to be a string")
  # expect_error(organization_members(organization = "UBC-MDS"), "Cannot extract data without authenticating.")
  token <- gh_auth(Sys.getenv("KEY"), Sys.getenv("SECRET"))

  organization <- "UBC -MDS"
  expect_warning(organization_members(organization,TRUE,token),
                 "Found white space in organization name. Removed spaces to check."
                 )
  organization <- "hakkunaaaaaaa matttaattaa"
  expect_error(organization_members(organization,TRUE,token),
               paste('Organization',
                     paste('"', str_replace(organization, fixed(" "), ""), '"', sep = ""),
                     'Not Found on GitHub')
               )

})

test_that("Check if output is valid",{
  token <- gh_auth(Sys.getenv("KEY"), Sys.getenv("SECRET"))
  org <- "UBC-MDS"

  expect_is(organization_members(org, TRUE,token), "list")

})
