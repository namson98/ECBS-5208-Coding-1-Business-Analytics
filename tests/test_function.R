library(testthat)

context('testing function integrity')

test_that('even_odd prints the right message', {
  expect_that(even_odd(1), prints_text('odd'))
  expect_that(even_odd(3), prints_text('even'))
})