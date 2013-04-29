#' Download ensemble statistics. Statistics can be from either two time periods:
#'  2046 - 2065 and 2081 - 2100. Derived statistics can be any of the following:
#'  tmin_means | Average daily minimum  temperature | degrees Celsius
#' tmax_means | Average daily maximum temperature | degrees Celsius
#' tmax_days90th | Number of days with maximum temperature above the control period’s 90th percentile (hot days) | days
#' tmin_days90th| Number of days with minimum  temperature above the control period’s 90th percentile (warm nights) |days
#' tmax_days10th | Number of days with maximum temperature below the control period’s 10th percentile (cool days) |days
#' tmin_days10th |Number of days with minimum  temperature below the control period’s 10th percentile (cold nights) | days
#' tmin_days0 | Number of days with minimum  temperature below 0 degrees Celsius | days
#' ppt_days | Number of days with precipitation greater than 0.2 mm | days
#' ppt_days2 | Number of days with precipitation greater than 2 mm | days
#' ppt_days10 | Number of days with precipitation greater than 10 mm | days
#' ppt_days90th | Number of days with precipitation greater than the control period's 90th percentile | days
#' ppt_dryspell | Average number of days between precipitation events | days
#' ppt_means | Average daily precipitation | mm
#' 
#' @import plyr
#' @param locator The ISO3 country code that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID [1-468]
#' @param stat The statistics of interest, must be one of the ones listed above.
#' @examples \dontrun{
#'  ### Request data on the US for days of rain over 2 mm
#'  ens_dat <- get_ensemble_stats("USA","mavg","ppt_days2")
#'  # subset to the 50th percentile and just until the year 2100
#'  ens_dat <- subset(ens_dat, ens_dat$percentile == 50)
#'  ens_dat <- subset(ens_dat,ens_dat$toYear == 2100)
#'  ggplot(ens_dat,aes(x = as.factor(month), y= monthVals, group=scenario, colour=scenario)) + geom_point() + geom_line()
#'}
#'@export


get_ensemble_stats <- function(locator,type,stat){
  ### check the stat is valid
  statvec <- c("tmin_means ","tmax_means","tmax_days90th","tmin_days90th","tmax_days10th","tmin_days10th","tmin_days0","ppt_days","ppt_days2","ppt_days10","ppt_days90th","ppt_dryspell","ppt_means") 
  if(!stat%in%statvec){
    stop(paste("Please enter a valid statistic to retrieve.","Must be one of the following:",statvec, " see help for details",sep="  "))
  }
  
  ## Error handling for type.  
  typevec <- c("mavg","annualavg","manom","annualanom")
  if(!type%in%typevec){
    stop("Please enter a valid data type to retrieve, see help for details")
  }
  
  
  
  ## Error handling for location input
  
  locator_check <- suppressWarnings( sum(is.na(as.numeric(locator))))
  if( locator_check == 0){
    geo_ref <- "basin"
  } else
    if(locator_check == length(locator)){
      geo_ref <- "country"
    } else {
      stop("You must enter either basin ID numbers or country codes, but not a mixed vector of both")
    }
  

  ### Set dates to retrieve both future scenarios.
  
  dates <- rbind(c(2046,2065),c(2081,2100))
  data_out <- list()
  counter <- 1
  for(i in 1:length(locator)){
    for(j in 1:length(dates[,1])){
      data_out[[counter]] <- get_ensemble_climate_data(locator[i],geo_type,type,stat,dates[j,1],dates[j,2])
      counter <- counter + 1
    }
  }
  
  
  return(ldply(data_out,data.frame))
}
