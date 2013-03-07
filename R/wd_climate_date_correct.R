#'Round start and end dates to conform with data api standards.  See api documentation (http://data.worldbank.org/developers/climate-data-api)
#'for full details
#'
#'@param start The start year
#'@param end The end year
#'@return a 2xM matrix where M in the number of periods in the data api

wd_climate_date_correct <- function(start, end){

  past <- matrix(c(1920,1939,1940,1959,1960,1979,1980,1999),nrow=4,ncol=2,byrow=T)
  future <- matrix(c(2020,2039,2040,2059,2060,2079,2080,2099),nrow=4,ncol=2,byrow=T)
  
  
}
