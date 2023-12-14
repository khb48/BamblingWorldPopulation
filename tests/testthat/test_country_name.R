library(testthat)
library(tidyverse)

testthat::test_that('Country Name is in data', {
  expect_error(CountryPopulation('Brazil'))
  expect_error(CountryPopulation('United Brazil'))
})
