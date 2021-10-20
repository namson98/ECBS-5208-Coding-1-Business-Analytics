# Testing is a vital part of package development. It ensures that your code does what you want it to do.
# You can always write custom tests
# While you are testing your code in this workflow, you’re only doing it informally.
# The problem with this approach is that when you come back to this code in 3 months time to add a new feature,
# you’ve probably forgotten some of the informal tests you ran the first time around. 
# This makes it very easy to break code that used to work.
# Automate your tests!

# Fewer bugs. Because you’re explicit about how your code should behave you will have fewer bugs.
# Better code structure. Code that’s easy to test is usually better designed. 
# Robust code. 
# 
# Hadley Wickham said it best, in his 2011 paper on his testthat package:
#   
# It’s not that we don’t test our code, it’s that we don’t store our tests so they can be re-run automatically.

# After you have the library loaded in and you’ve set the working directory to the right place,
# you can run the testing suite by calling test_file('file_to_test.R').
# The advantage to calling this function, rather than just sourcing the file,
# is that it will run through all tests even if some fail. When you source it,
# the test script halts at the first error. If you have multiple testing files,
# syou can call test_dir('my_test_dir/') instead, and it will run all of the test_ files in that directory.

testing_data <- data.frame('letters'=c('a', 'b', 'c', 'd'),
                           'numbers'=seq(1, 4))
print(testing_data)

model_data = data.frame('y'=c(rnorm(25, 0, 1), rnorm(25, 1, 1)),
                        'x'=rep(c('c1', 'c2'), each=25))
test.mod = lm(y ~ x, data=model_data)

even_odd = function(n){
  ifelse(n %% 2 == 0, print('even'), print('odd'))
}

#run these tests
testthat::test_file("tests/test_dataframe.R")

testthat::test_file("tests/test_model.R")

testthat::test_file("tests/test_function.R")
