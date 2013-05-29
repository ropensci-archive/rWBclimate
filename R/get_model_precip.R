#'Download GCM precipitation data
#'@description Function wraps get_climate_data() and returns precipitation
#'by basin or country in mm as output from all 15 models, for the a1 and b2 scenarios. 
#'
#'@param locator A vector of either watershed basin ID's from http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf
#'       It can be just a single basin id, or a vector of ids.  ids should be strings.
#'@param type the type of data to retrieve, must be "mavg" for monthly averages,
#'       "annualavg" for annual averages, "manom" for monthly anomaly, and "annualanom" for 
#'       annual anomaly.        
#'@param start the start year to gather data for.
#'@param end the end year to gather data to.
#'@return a dataframe with precipitation predictions in mm for all scenarios, gcms, for each time period.
#'@details start and end year can be any years, but all years will be coerced
#'         into periods outlined by the API (http://data.worldbank.org/developers/climate  -data-api)
#'         anomaly periods are only valid for future scenarios and based on a 
#'         reference period of 1969 - 1999, see API for full details.
#'@examples \dontrun{
#'# Get data for 2 basins, annual average precipitation for all valid time periods
#'# then subset them, and plot
#' precip_dat <- get_model_precip(c("2","231"),"annualavg",1900,3000)
#' precip_dat <- subset(precip_dat,precip_dat$gcm=="ukmo_hadcm3")
#' precip_dat <- subset(precip_dat,precip_dat$scenario!="b1")
#' ggplot(precip_dat,aes(x=fromYear,y=annualData,group=locator,colour=locator))+geom_path()
#' 
#' ### Get data for 4 countries with monthly precipitation values
#' precip_dat <- get_model_precip(c("USA","BRA","CAN","YEM"),"mavg",2020,2030)
#' precip_dat <- subset(precip_dat,precip_dat$gcm=="ukmo_hadcm3")
#' precip_dat <- subset(precip_dat,precip_dat$scenario!="b1")
#' ggplot(precip_dat,aes(x=as.factor(month),y=monthVals,group=locator,colour=locator))+geom_path()
#'}
#'@export

get_model_precip <- function(locator,type, start, end){
  ### check type is valid
  typevec <- c("mavg","annualavg","manom","annualanom")
  if(!type%in%typevec){
    stop("Please enter a valid data type to retrieve, see help for details")
  }
  
  if(start < 2000 && type%in%typevec[3:4]){
    stop("Anomaly requests are only valid for future scenarios")
  }
  #Convert numeric basin numbers to strings if they were entered incorrectly
  locator <- as.character(locator)
  geo_ref <- check_locator(locator)
  
  output <- get_data_recursive(locator,geo_ref,type, "pr", start, end)
  return(output)
}

