library(testthat)

context('testing data integrity')

test_that('data dimensions correct', {
  expect_equal(ncol(testing_data), 2)
  expect_equal(nrow(testing_data), 4)
})

test_that('no missing values', {
  expect_identical(testing_data, na.omit(testing_data))
})

test_that('data types correct', {
  expect_is(testing_data,'data.frame')
  expect_is(testing_data$numbers, 'integer')
  expect_is(testing_data$letters, 'character') #this one fails; they're characters
})