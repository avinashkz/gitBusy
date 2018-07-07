context('repo_count.R')
context('get_auth.R')

library(httr)
library(glue)

token <- gh_auth(Sys.getenv("KEY"), Sys.getenv("SECRET"))

#check error message
test_that("check if the error message is correct",{

  expect_error(repo_count("avinashkzz", TRUE, token), 'User avinashkzz Not Found on GitHub',fixed=TRUE)

  expect_error(repo_count("avinashkz", auth = TRUE), "Cannot extract data without authenticating.")

  expect_warning(repo_count("avinashkz ", auth = TRUE, token), "Found white space in username. Removed spaces to check.")

})

#check valid output
test_that('the output has two elements only',{
  expect_equal(repo_count("avinashkz", TRUE, token),37)
})

test_that("Check if output is valid",{

  #With authentication
  output <- repo_count("sarora", TRUE, token)
  expect_true(typeof(output)=='integer')

  #Without authentication
  #output <- repo_count("sarora")
  #expect_true(typeof(output)=='integer')

})
