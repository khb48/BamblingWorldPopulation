library(tidyverse)
library(readxl)

w_pop <- read_excel( '..\\World_Population.xlsx', sheet='ESTIMATES', col_names = TRUE, skip = 16 )

WorldPopulation <- w_pop %>%
  filter(str_detect(w_pop$Type, 'Country/Area')) %>%
  select(c(3, 8:78))

colnames(WorldPopulation)[1] <- 'Country Names'

usethis::use_data(WorldPopulation, overwrite = TRUE)
