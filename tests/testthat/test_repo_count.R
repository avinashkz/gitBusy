context('repo_count.R')

library(httr)
library(glue)
library(dplyr)
library(purrr)
library(ggplot2)
library(forcats)

#check valid input
test_that("check if input is in correct format",{
  expect_error(repo_count("avinashkzz"), 'User avinashkzz Not Found on GitHub',fixed=TRUE)
})

#check valid output
test_that('the output has two elements only',{
  expect_equal(repo_count("avinashkz"),32)
})

test_that("Check if output is valid",{
  output <- repo_count("avinashkz")
  expect_true(typeof(output)=='integer')

})
