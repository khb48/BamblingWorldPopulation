library(tidyverse)
library(rvest)

url = 'https://en.wikipedia.org/wiki/FIFA_World_Cup'
page <- read_html(url)

avg_attend <- page %>% html_nodes('table') %>% .[[4]] %>% html_table(header=FALSE, fill=TRUE) %>% slice(3:27)

World_Cup <- avg_attend %>% select(c(1,2,4,5,6)) %>% magrittr::set_colnames(c('Year', 'Hosts', 'Totalattendance', 'Matches', 'Averageattendance'))
World_Cup <- World_Cup %>%
  mutate( Totalattendance = as.numeric( str_replace_all(World_Cup$Totalattendance, pattern=',', replacement='') ) ) %>%
  mutate( Averageattendance = as.numeric( str_replace_all(World_Cup$Averageattendance, pattern=',', replacement='') ) ) %>%
  mutate( Matches = as.numeric( World_Cup$Matches ) ) %>%
  drop_na()

World_Cup <- World_Cup %>% mutate(WorldCup = str_c(Hosts, Year), Hosts=NULL, Year=NULL)
World_Cup <- World_Cup %>%
  mutate( WorldCup = str_replace_all(World_Cup$WorldCup, pattern=' ', replacement='') )

usethis::use_data(World_Cup, overwrite = TRUE)
