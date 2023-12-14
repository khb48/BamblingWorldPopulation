#' \title{Country Population}
#'
#' \description{Creates a graph of the population of input country by year from 1950 to 2020.}
#'
library(tidyverse)

CountryPopulation <- function(country_name){
  WorldPopLong <- WorldPopulation %>%
    pivot_longer('1950':'2020') %>%
    magrittr::set_colnames(c('Country', 'Year', 'Population')) %>%
    filter(str_detect(Country, paste('^', country_name, '$', sep = '')) )

  ifelse(!str_detect(Country, paste('^', country_name, '$', sep = '')), stop('Country Name Invalid'))

  graph <- WorldPopLong %>% ggplot( aes(x=Year, y=as.numeric(Population)) ) +
    geom_point() +
    labs(y='Population', title = paste('Year vs Population of', country_name)) +
    scale_x_discrete(breaks = seq(1950,2020, by=10))

  return(graph)
}
