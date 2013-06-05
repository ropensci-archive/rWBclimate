#'Map climate data
#'@description Create maps of climate data.  It requires two data inputs, a 
#'map dataframe, and a climate dataframe.  The climate data 
#'
#'@param locator A vector of either watershed basin ID's from http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf
#'       It can be just a single basin id, or a vector of ids.  ids should be strings.
#'@param type the type of data to retrieve, must be "mavg" for monthly averages,
#'       "annualavg" for annual averages, "manom" for monthly anomaly, and "annualanom" 
#'        for annual anomaly.        
#'@param start the start year to gather data for.
#'@param end the end year to gather data to.
#'@return a dataframe with temperature predictions in degrees C for all scenarios, gcms, for each time period.
#'@details start and end year can be any years, but all years will be coerced
#'         into periods outlined by the API (http://data.worldbank.org/developers/climate  -data-api)
#'         anomaly periods are only valid for future scenarios and based on a 
#'         reference period of 1969 - 1999, see API for full details.
#'@examples \dontrun{
#'# Get data for 2 basins, annual average temperature for all valid time periods
#'# then subset them, and plot
#' temp_dat <- get_model_temp(c("2","231"),"annualavg",1900,3000)
#' temp_dat <- subset(temp_dat,temp_dat$gcm=="ukmo_hadcm3")
#' temp_dat <- subset(temp_dat,temp_dat$scenario!="b1")
#' ggplot(temp_dat,aes(x=fromYear,y=annualData,group=locator,colour=locator))+geom_path()
#' 
#' ### Get data for 4 countries with monthly tempitation values
#' temp_dat <- get_model_temp(c("USA","BRA","CAN","YEM"),"mavg",2020,2030)
#' temp_dat <- subset(temp_dat,temp_dat$gcm=="ukmo_hadcm3")
#' temp_dat <- subset(temp_dat,temp_dat$scenario!="b1")
#' ggplot(temp_dat,aes(x=as.factor(month),y=monthVals,group=locator,colour=locator))+geom_path()
#'}
#'@export

climate_map <- function(map_df, data_df, return_map = TRUE){
  ### You can't plot more that one piece of data on a map
  ### so we need to check that there's not more data than regions to plot
  if(length(unique(map_df$ID)) != dim(data_df)[1]){
    stop("You can't have more than one piece fo data for each region to map")
  }
  ## Order data for easy matching
  data_df <- data_df[order(data_df$locator),]
  map_df <- map_df[order(map_df$ID),]
  
  ids <- unique(map_df$ID)
  data_vec <- vector()
  for(i in 1:length(ids)){
    data_vec <- c(data_vec,rep(data_df$data[i],sum(map_df$ID==ids[i])))
  }
  
  map_df$data <- data_vec
  map <- ggplot(map_df, aes(x=long, y=lat,group=group,fill=as.factor(data)))+ geom_polygon()
  if(return_map == TRUE){return(map)
  } else {return(map_df)}
}
