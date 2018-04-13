context('repo_count.R')


#check valid output
test_that('the output has two elements only',{
  expect_equal(repo_count("avinashkz"),32)
})
