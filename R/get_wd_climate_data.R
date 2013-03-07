#' Download monthly average climate data from the world bank climate data
#' 
#' @param country The ISO3 country code you want data for.
#' @param type The type of data you're interested in. pr for precipitation, temp for temperature in celcius
#' @param start The starting year you want data for, can be in the past or the future. Must conform to the periods outlined in the world bank API.  If given values don't conform to dates, the fuction will automatically round them.
#' @param end The ending year you want data for, can be in the past or the future.  Similar to the start date, dates will be rounded to the nearest end dat.
#' 
#' 

get_wd_month_climate_data <- function(country,  type, start, end){
  base_url <- "http://climatedataapi.worldbank.org/climateweb/rest/v1/country/"
  data_url <- paste(type,start,end,country,sep="/")
  extension <- ".json"
  full_url <- paste(base_url,data_url,extension,sep="")
  parsed_data <- content(GET(full_url),as="parsed")
}