#'Function wraps get_wd_climate_data() and returns temperature data from GCM's in 
#'degrees celcisus. The function is useful because it removes some of the complicated
#'parameters for the API and prevents bad calls.
#'
#'@param country Valid 3 letter ISO3 Country code from http://unstats.un.org/unsd/methods/m49/m49alpha.htm
#'       It can be just a single country code, or a vector of country codes.
#'@param type the type of data to retrieve, must be "mavg" for monthly averages,
#'       "annualavg" for annual averages, "manom" for monthly anomaly, and "annualanom"
#'       for annual anomaly.        
#'@param start the start year to gather data for.
#'@param end the end year to gather data to.
#'@return a dataframe with data for all scenarios, gcms, for each time period and each 
#'        country, returned as the average annual or monthly amount of precipitation in mm
#'@details start and end year can be any years, but all years will be coerced
#'         into periods outlined by the API (http://data.worldbank.org/developers/climate  -data-api)
#'         anomaly periods are only valid for future scenarios and based on a 
#'         reference period of 1969 - 1999, see API for full details.
#'@examples \dontrun{
#' # Get data for 2 countries, annual average temperature for all valid time periods
#' #then subset them, and plot
#' country_dat <- country_precip(c("USA","BRA"),"annualavg",1900,3000)
#' country_dat <- subset(country_dat,country_dat$gcm=="ukmo_hadcm3")
#' country_dat <- subset(country_dat,country_dat$scenario!="b1")
#' ggplot(country_dat,aes(x=fromYear,y=annualData,group=locator,colour=locator))+geom_path()

#'@export

country_precip <- function(country,type, start, end){
  ### check type is valid
  typevec <- c("mavg","annualavg","manom","annualanom")
  if(!type%in%typevec){
    stop("Please enter a valid data type to retrieve, see help for details")
  }
  
  if(start < 2000 && type%in%typevec[3:4]){
    stop("Anomaly requests are only valid for future scenarios")
  }
  
  
  output <- get_wd_data_recursive(country,"country",type, "pr", start, end)
  return(output)
}