library(testthat)

context('testing model integrity')

test_that('right number of coefficients', {
  expect_equal(length(test.mod$coefficients), 2)
})

test_that('mean of group 1 equals intercept', {
  expect_equivalent(mean(model_data$y[model_data$x == 'c1']), test.mod$coefficients['(Intercept)'])
})

test_that('all factor levels present', {
  expect_equivalent(levels(model_data$x), unlist(test.mod$xlevels))
})