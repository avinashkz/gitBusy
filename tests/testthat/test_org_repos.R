context('organization_repos.R')
library(testthat)
library(stringr)

# Same test functions for both Org_repos and Org_members
test_that("check if input is in correct format",{

  org <- "UBC-MDS"
  expect_error(org_repos(NULL), "Organization input needs to be a string")
  expect_error(org_repos(1234), "Organization input needs to be a string")
  expect_error(org_repos(organization = "UBC-MDS", auth = TRUE), "Cannot extract data without authenticating.")
  token <- gh_auth(Sys.getenv("KEY"), Sys.getenv("SECRET"))

  organization <- "UBC -MDS"
  expect_warning(org_repos(organization,TRUE,token),
                 "Found white space in organization name. Removed spaces to check."
  )
  organization <- "hakkunaaaaaaa matttaattaa"
  expect_error(org_repos(organization,TRUE,token),
               paste('Organization',
                     paste('"', str_replace(organization, fixed(" "), ""), '"', sep = ""),
                     'Not Found on GitHub')
  )

})

test_that("Check if output is valid",{
  token <- gh_auth(Sys.getenv("KEY"), Sys.getenv("SECRET"))
  org <- "UBC-MDS"

  #With authentication
  output <- org_repos(org, TRUE,token)
  expect_true(is.data.frame(output))

  #Without authentication
  #output <- org_repos(org)
  #expect_true(is.data.frame(output))
})
