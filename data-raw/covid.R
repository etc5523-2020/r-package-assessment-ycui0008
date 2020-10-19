## code to prepare `covid` dataset goes here

library(readr)
library(janitor)

url <- 'https://covid19.who.int/WHO-COVID-19-global-data.csv'

covid <- read_csv(url) %>%
  clean_names()

usethis::use_data(covid, overwrite = TRUE)
