#' Download monthly average climate data from the world bank climate data
#' 
#' @param country The ISO3 country code you want data for.
#' @param time_scale The time scale of data you are interested in: monthly for monthly data or annual for annual data
#' @param type The type of data you're interested in. pr for precipitation, temp for temperature in celcius
#' @param start The starting year you want data for, can be in the past or the future.
#' @param end The ending year you want data for, can be in the past or the future
#' 

get_wd_climate_data <- function(country, time_scale, type, start, end){
  base_url <- "http://climatedataapi.worldbank.org/climateweb/rest/v1/country/"
  data_url <- paste(time_scale,type,start,end,country,sep="/")
  extension <- ".json"
  full_url <- paste(base_url,data_url,extension,sep="")
  parsed_data <- content(GET(full_url),as="parsed")
}