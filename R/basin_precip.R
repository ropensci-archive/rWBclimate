#'Function wraps get_wd_climate_data() and returns monthly average precipitation
#'by basin in mm.  The function is useful because it removes some of the complicated
#'parameters for the API and prevents bad calls.
#'
#'@param ID basin ID from http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf
#'       It can be just a single basin id, or a vector of ids.  ids should be strings.
#'@param type the type of data to retrieve, must be "mavg" for monthly averages,
#'       "annualavg" for annual averages, "manom" for monthly anomaly, and "annualanom" for 
#'       annual anomaly.        
#'@param start the start year to gather data for.
#'@param end the end year to gather data to.
#'@return a dataframe with precipitation predictions in mm for all scenarios, gcms, for each time period and each 
#'        basin ID.
#'@details start and end year can be any years, but all years will be coerced
#'         into periods outlined by the API (http://data.worldbank.org/developers/climate  -data-api)
#'         anomaly periods are only valid for future scenarios and based on a 
#'         reference period of 1969 - 1999, see API for full details.
#'@examples \dontrun{
#'# Get data for 2 basins, annual average precipitation for all valid time periods
#'# then subset them, and plot
#' basin_dat <- basin_precip(c("2","231"),"annualavg",1900,3000)
#' basin_dat <- subset(basin_dat,basin_dat$gcm=="ukmo_hadcm3")
#' basin_dat <- subset(basin_dat,basin_dat$scenario!="b1")
#' ggplot(basin_dat,aes(x=fromYear,y=annualData,group=locator,colour=locator))+geom_path()
#'}
#'@export

basin_precip <- function(ID,type, start, end){
  ### check type is valid
  typevec <- c("mavg","annualavg","manom","annualanom")
  if(!type%in%typevec){
    stop("Please enter a valid data type to retrieve, see help for details")
  }
  
  if(start < 2000 && type%in%typevec[3:4]){
    stop("Anomaly requests are only valid for future scenarios")
  }
  
  
  output <- get_wd_data_recursive(ID,"basin",type, "pr", start, end)
  return(output)
}

