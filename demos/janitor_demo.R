install.packages("janitor")

library(readxl); library(janitor); library(dplyr); library(here)

rm(list = ls())

roster_raw <- read_excel(here("demos", "dirty_data.xlsx"))

roster_raw

glimpse(roster_raw)

#tidyverse-oriented package so works well with pipes

roster_raw_clean_names <- roster_raw %>%
  row_to_names(row_number = 1) %>%
  clean_names(case = "snake")

names(roster_raw)
names(roster_raw_clean_names)

roster <- roster_raw_clean_names %>%
  remove_empty(c("rows", "cols")) %>%
  remove_constant(na.rm = TRUE, quiet = FALSE) %>% # remove the column of all "Yes" values 
  mutate(hire_date = convert_to_date(hire_date, # handle the mixed-format dates
                                     character_fun = lubridate::mdy),
         cert = dplyr::coalesce(certification, certification_2)) %>%
  select(-certification, -certification_2) # drop unwanted columns
#> Removing 1 constant columns of 10 columns total (Removed: active).

View(roster)

compare_df_cols(roster_raw_clean_names, roster)

roster %>% get_dupes(contains("name"))
# some teachers appear twice

# tabyl()
# 
# Like table(), but pipe-able, data.frame-based, and fully featured.

roster %>%
  tabyl(subject)

roster %>%
  filter(hire_date > as.Date("1950-01-01")) %>%
  tabyl(employee_status, full_time)

roster %>%
  tabyl(full_time, subject, employee_status, show_missing_levels = FALSE)

roster %>%
  tabyl(employee_status, full_time) %>%
  adorn_totals("row") %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting() %>%
  adorn_ns() %>%
  adorn_title("combined")

write.xlsx(roster, file="clean_data.xlsx", 
           sheetName="Clean")

