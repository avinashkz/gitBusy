context('user_preferences.R')
library(testthat)
library(httr)
library(glue)

test_that("check if input is in correct format",{

token <- gh_auth(Sys.getenv("KEY"), Sys.getenv("SECRET"))
### Passing null instead of a string
expect_error(user_preferences(NULL, token), "GitHub user Id needs to be a string")
### Passing an integer instead of a string
expect_error(user_preferences(1234,token), "GitHub user Id needs to be a string")
### USer id does not exist. Please enter a valid id
expect_error(user_preferences("sadadadasa",token), paste('User', paste('"', "sadadadasa", '"', sep = ""), 'Not Found on GitHub'))
})


test_that("Check if output is valid",{
  token <- gh_auth(Sys.getenv("KEY"), Sys.getenv("SECRET"))

  ### Checking if the length of the list returned is 2
  expect_equal(length(user_preferences("sarora",token)),2)

  ### Checking if type of the first argument returned is a list.
  expect_equal(typeof(user_preferences("sarora",token)[[1]]), "list")

  ### checking if the length of the tibble returned in the first argument is 2: language and count
  expect_equal(length(user_preferences("sarora",token)[[1]]), 2)

  ### checking if the type of the first argument returned by the method is a character. This is character here.
  expect_equal(typeof(user_preferences("sarora",token)[[1]][[1]]), "character")

  ### checking if the type of the second argument returned by the method is a integer. This is count here.
  expect_equal(typeof(user_preferences("sarora",token)[[1]][[2]]), "integer")
})
