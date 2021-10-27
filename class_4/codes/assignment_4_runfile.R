#########################
## Assignment 4        ##
##      CLASS 4        ##
##  Deadline:          ##
##  2021/11/2 17:40   ##
#########################

##
# Create your own theme for ggplot!
#   DONE
# 0) Clear your environment

rm(list=ls())

# 1) Load tidyverse

library(tidyverse)

# 2) use the same dataset as in class:
df <- read_csv( "https://raw.githubusercontent.com/CEU-Economics-and-Business/ECBS-5208-Coding-1-Business-Analytics/master/class_4/data/hotels-vienna-london.csv" )

# 3) Call your personalized ggplot function

source("theme_colorized.R")

# 4) Run the following piece of command:
ggplot( filter( df , city == 'Vienna' ) , aes( x = price) ) +
  geom_histogram(alpha = 0.8, binwidth = 20, aes(fill = offer_cat)) +
  labs(x='Hotel Prices in  Vienna',y='Density')+
  theme_colorized()
