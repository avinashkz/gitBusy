context('repo_count.R')

library(httr)
library(glue)

#check error message
test_that("check if the error message is correct",{
  expect_error(repo_count("avinashkzz"), 'User avinashkzz Not Found on GitHub',fixed=TRUE)
})

#check valid output
test_that('the output has two elements only',{
  expect_equal(repo_count("avinashkz", TRUE),32)
})

test_that("Check if output is valid",{
  output <- repo_count("sarora", TRUE)
  expect_true(typeof(output)=='integer')

})
