rm(list=ls())

#### LOOPS

for (i in 1:5){
  print(i)
}

for (i in seq(50,58)){
  print(i)
}

for (i in c(10,9,-10,8)){
  print(i)
}

for (i in list(2, 'a', TRUE, sqrt(2))){
  print(i)
}

v <- c(10,6,5,32,45,23)
k = 0
for (i in v){
  k = k + i
  print(k)
}

for (i in seq_along(v)){
  k <- k + v[i]
}


#Measure cpu time

install.packages('tictoc')  
library(tictoc)

iter_num <- 10000

tic("Sloppy way")
q <- c()
for (i in 1:iter_num){
  q <- c(q, i)
}
toc()

tic("Good way")
r <- double(length = iter_num)
for (i in 1:iter_num){
  r[i] <- i
}
toc()

x <- 0
while(x<10){
  x <- x + 1
  print(x)
}

max_iter <- 10000
x <- 0
for (i in 1:max_iter){
  if (x < 10){
    x <- x+1
  }else{
    break
  }
}

#### RANDOM NUMBERS
set.seed(1234)
n <- 10
x <- runif(n, min = 0, max = 10)
x

n <- 10000
y <- rnorm(n, mean = 1, sd = 2)
library(tidyverse)
df <- tibble( var1 = y )
ggplot( df, aes(var1))+
  geom_histogram(aes(y=..density..), fill='navyblue') +
  stat_function(fun = dnorm, args = list(mean = 1, sd = 2),
                color = 'red',  size = 1.5)

# sampling
sample_1 <- sample(y, 100, replace=F)


j <- c()
for (i in 1:1000){
  set.seed(i)
  j[i] <- mean(sample(y, 100, replace=F))
}

df_m <- tibble(means = j)
ggplot(df_m, aes(means))+
  geom_histogram(aes(y=..density..), fill = 'navyblue') +
  stat_function(fun=dnorm, args = list(mean=1,
                                       sd = (2/sqrt(100))),
                color = 'red', size = 1.5)


