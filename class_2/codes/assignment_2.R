##########################
##     HOMEWORK         ##
##      CLASS 2         ##
##       CEU            ##
##########################

# 0) Clear work space

rm( list = ls() )

# 1) Load both data from github page and inspect (summary,glimpse)
#   Hint: you will need the `raw.github...` url address

library(tidyverse)

schools <- read_csv(url("https://raw.githubusercontent.com/CEU-Economics-and-Business/ECBS-5208-Coding-1-Business-Analytics/master/class_2/data/assignment_2/raw/CASchools_schools.csv"))
scores <- read_csv(url("https://raw.githubusercontent.com/CEU-Economics-and-Business/ECBS-5208-Coding-1-Business-Analytics/master/class_2/data/assignment_2/raw/CASchools_scores.csv"))
summary(schools)
summary(scores)
glimpse(schools)
glimpse(scores)

# 2) Merge the two data table into one called `df`
df <- full_join(schools, scores, by="district")

# 3) Put the district variable into numeric format
df$district <- as.numeric(df$district)

# 4) Create two new variables from `school_county`: 
#     - school should contain only the name of the school - character format
#     - county should only contain the name of the county - factor format

df_new <- separate( df , school_county , " - " ,
                into = c("school","country"), remove=TRUE)

df_new$country <- as.factor(df_new$country)

# 5) Find missing values, write 1 sentence what and why to do what you do and execute.
# as they seems to be completely random, we can drop these observations

# With the is.na() function we check for each value whether it is missing or not,
# so it gives back an array of booleans where TRUE represents NA values at that index
# Then we can ask the question from R that which values are those indexes which were defined TRUE.

which(is.na(df_new))

# 6) Create a new variable called `score` which averages the english, math and read scores

df_new <- df_new %>%
            mutate(scores = rowMeans(cbind(math, read, english), na.rm=TRUE))

# 7) Find the county which has the largest number of schools in the data 
#     and calculate the average and the standard deviation of the score.

dfcount <- df_new %>%
  group_by(country) %>%
    count()

dfcount[which.max( dfcount$n ),]
#Sonoma with 29 schools

sonoma <- df_new %>%
  filter(country=="Sonoma")

sd(sonoma$scores)
# 20.27482
mean(sonoma$scores)
# 443.3175
