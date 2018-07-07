context('repo_count.R')
context('get_auth.R')

library(httr)
library(glue)

token <- gh_auth(Sys.getenv("KEY"), Sys.getenv("SECRET"))

#check error message
test_that("check if the error message is correct",{
  #saveRDS(token, file = "github_token.rds")
  #gtoken <- readRDS(file = "github_token.rds")
  expect_error(repo_count("avinashkzz", TRUE, token), 'User avinashkzz Not Found on GitHub',fixed=TRUE)
})

#check valid output
test_that('the output has two elements only',{
  expect_equal(repo_count("avinashkz", TRUE, token),37)
})

test_that("Check if output is valid",{
  output <- repo_count("sarora", TRUE, token)
  expect_true(typeof(output)=='integer')

})
