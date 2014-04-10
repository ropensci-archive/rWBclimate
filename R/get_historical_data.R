#'Download historical climate data
#'
#' @description The Climate Data API provides access to historical temperature
#' and precipitation data. These data are separate from the outputs of the GCMs,
#' and they are based on gridded climatologies from the Climate Research Unit.
#' 
#' @import httr plyr jsonlite
#' @param locator The ISO3 country code that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID [1-468].
#' The historical period for country is 1901 - 2009, and 1960 - 2009 for basin 
#' @param cvar The climate variable you're interested in. "\emph{pr}" for precipitation, "\emph{tas}" for temperature in celcius.
#' @param time_scale The time scale you want to return values on.  Must be "\emph{month}", "\emph{year}" or "\emph{decade}"
#' @return a dataframe with historical climate data 
#' @details The time_scale parameter returns a different number of variables depending on the input timescale. \emph{Month} will return 12 values, a historical average for that month across all years.  \emph{Year} will return yearly averages for each year, and \emph{decade} will return decade averages.
get_historical_data <- function(locator,cvar,time_scale){
base_url <- "http://api.worldbank.org/climateweb/rest/v1/"

### check cvar is valid
var_vec <- c("tas","pr")
if(!cvar%in%var_vec){
  stop("Please enter a valid variable to retrieve, either 'tas' for temperature or 'pr' for precipitation ")
}

#check for valid time scale 
time_vec <- c("month","year","decade")
if(!time_scale%in%time_vec){
  stop("Please enter a valid time period, see help for details")
}
#Convert numeric basin numbers to strings if they were entered incorrectly
locator <- as.character(locator)
geo_type <- check_locator(locator)

### Error handling
if(geo_type == "country"){
  check_ISO_code(locator)
}

if(geo_type == "basin"){
  if(is.na(as.numeric(locator))){
    stop("You must enter a valid Basin number between 1 and 468")
  }
  if(as.numeric(locator) < 1 || as.numeric(locator) > 468){
    as.numeric(locator) < 1 || as.numeric(locator) > 468
  }
}

data_url <- paste(geo_type,"cru",cvar,time_scale,locator,sep="/")
extension <- ".json"
full_url <- paste(base_url,data_url,extension,sep="")
raw_data <- try(content(GET(full_url),as="text"),silent=T)

if(sum(grep("unexpected",raw_data)) > 0){
  stop(paste("You entered a country for which there is no data. ",locator," is not a country with any data"))
}

data_out <- jsonlite::fromJSON(raw_data)
# data_out <- data.frame(do.call(rbind, parsed_data))

if(time_scale == "month"){
  m <- c("Jan","Feb","Mar","April","May","June","July","Aug","Sep","Oct","Nov","Dec")
  data_out$month <- factor(m,levels=m)
  
}

data_out$locator <- rep(locator,dim(data_out)[1])

return(data_out)
}