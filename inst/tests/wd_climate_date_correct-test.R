context("timeframe")
test_that("Strings are not accepted",{
  expect_error(wd_climate_date_correct("34",32),"Please input dates as numbers not strings")
})
test_that("Vectors are not accepted", {
  expect_error(wd_climate_date_correct(c(23,3,2)),"Please input a single start and end date")
})

