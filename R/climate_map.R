#'Map climate data
#'@description Create maps of climate data.  It requires two data inputs, a map dataframe, and a climate dataframe.  The climate data must have one data point per spatial mapping point,e.g. 1 data point per country or basin being mapped.
#'
#'@param map_df a map dataframe generated from create_map_df()
#'@param data_df a climate dataframe with one piece of data to be mapped to each unique spatial polygon.
#'@param return_map True returns a ggplot2 object, False returns a dataframe where data items are matched to their polygon that you can plot later on.
#'@return Either a ggplot2 map or a dataframe depending on the parameter return_map
#'@examples \dontrun{
#' #Set the kmlpath option
#' options(kmlpath = "/Users/edmundhart/kmltemp")
#' ##Here we use a list basins for Africa
#' af_basin <- create_map_df(Africa_basin)
#' af_basin_dat <- get_ensemble_temp(Africa_basin,"annualanom",2080,2100)
#' ##  Subset data to just one scenario, and one percentile
#' af_basin_dat <- subset(af_basin_dat,af_basin_dat$scenario == "a2")
#' af_basin_dat <- subset(af_basin_dat,af_basin_dat$percentile == 50)
#' af_map <- climate_map(af_basin,af_basin_dat,return_map = T)
#' af_map + scale_fill_continuous("Temperature \n anomaly",low="yellow",high = "red") + theme_bw()
#'  
#'}
#'
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
  
  if(is.list(data_vec)){
    data_vec <- unlist(data_vec)
  }
  
  map_df$data <- data_vec
  map <- ggplot(map_df, aes(x=long, y=lat,group=group,fill=data))+ geom_polygon()
  if(return_map == TRUE){return(map)
  } else {return(map_df)}
}
