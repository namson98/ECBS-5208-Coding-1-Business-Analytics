##################
# Assignment 5   #
# Deadline:      #
#  Nov. 24:      # 
#     13.30      #
##################


##
# You will look at measurement error in hotel ratings!

# 0) Clear memory and import packages (tidyverse and fixest is enough for this assignment)
rm(list = ls())


# Loading packages with pacman
if (!require("pacman")) {
  install.packages("pacman")
}


pacman::p_load(tidyverse,
               fixest,
               data.table, 
               patchwork)

# 1) Load Vienna and do a sample selection:
# Apply filters:  3-4 stars, no NA from stars, Vienna actual, 
#   without  extreme value: price <= 600

hotels <- read_csv("https://osf.io/y6jvb/download")

hotels <- hotels %>% 
            filter(stars %in% c(3,4),
                 city_actual == 'Vienna',
                 price <= 600)

# 2) Create a variable which takes the log price
# And define two cutoffs: k1 = 100, k2=200 for rating count

hotels <- hotels %>% 
            mutate(lprice = log(price))

k1 = 100
k2 = 200 

# 3-5) Run 3 regressions on DIFFERENT SAMPLES:
#     reg1: logprice = alpha + beta + rating: data = rating_count < k1
#     reg2: logprice = alpha + beta + rating: data = k1 <= rating_count < k2
#     reg3: logprice = alpha + beta + rating: data = rating_count >= k2
# and save the predicted values as: yhat1, yhat2, yhat3 into the hotels tibble

# Create subsets

df1 <- filter(hotels, rating_count < k1)

df2 <- filter(hotels, rating_count >= k1, rating_count < k2)

df3 <- filter(hotels, rating_count >= k2)

# Run regressions

reg1 <- feols(lprice ~ rating, data = df1)
reg2 <- feols(lprice ~ rating, data = df2)
reg3 <- feols(lprice ~ rating, data = df3)

# Add columns for fitted values and cast to data.table as rbind fill not compatible with tibble

dt1 <- df1 %>% 
          mutate(yhat1 = predict(reg1)) %>% data.table()

dt2 <- df2 %>% 
          mutate(yhat2 = predict(reg2)) %>% data.table()

dt3 <- df3 %>% 
          mutate(yhat3 = predict(reg3)) %>% data.table()

hotels <- rbind(df1, df2, df3, fill = TRUE)

# 6) Create a simple summary table for the three models.

etable(reg1, reg2, reg3)

# 7) Create a Graph, which plots the rating agians yhat1 and yhat3 with a simple line
# also add an annotation: yhat1: `More noisy: # of ratings<100`
#                         yhat3: `Less noisy: # of ratings>200`
#
# Take care of labels, axis limits and breaks!

# Function for extracting regression coefficients and create annotation
lm_eqn <- function(df){
  m <- lm(lprice ~ rating, df);
  eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2, 
                   list(a = format(unname(coef(m)[1]), digits = 2),
                        b = format(unname(coef(m)[2]), digits = 2),
                        r2 = format(summary(m)$r.squared, digits = 3)))
  as.character(as.expression(eq));
}

f1 <- ggplot(aes(rating, yhat1), data = dt1) +
      geom_line(color = 'red') +
      geom_text(x = 4, y = 4.4, label = lm_eqn(dt1), parse = TRUE) +
      geom_text(x = 4, y = 4.35, label = "More noisy -> lower RSquared") +
      labs(x = 'Ratings',
           y = 'Predicted log prices',
           title = "Ratings x Price (ratings < 100)") +
      theme_classic()

f2 <- ggplot(aes(rating, yhat3), data = dt3) +
      geom_line(color = 'blue') +
      geom_text(x = 4.4, y = 4.5, label = lm_eqn(dt3), parse = TRUE) +
      geom_text(x = 4.4, y = 4.4, label = "Less noisy -> higher RSquared") +
      labs(x = 'Ratings',
           y = 'Predicted values',
           title = "Ratings x Price (ratings > 200)") +
      theme_classic()

# This could take time to render

f1 + f2 + plot_layout(guides = 'collect') + plot_annotation(
  title = 'Relationship between log price and ratings',
  subtitle = 'Based on cutoff values for ratings',
  caption = 'by Nam Son Nguyen'
) 


