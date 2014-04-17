#' Download ensemble statistics
#' @description  Statistics can be from either two time periods: 2046 - 2065 and 2081 - 2100 and are all given in units relative to a control period:  1961 - 2000.  Derived statistics can be any of the following:
#' 
#' \tabular{lll}{
#' \strong{Statistic} \tab \strong{Description} \tab \strong{Units} \cr
#'\emph{tmin_means} \tab Average daily minimum  temperature \tab degrees Celsius \cr 
#'\emph{tmax_means} \tab Average daily maximum temperature \tab degrees Celsius \cr 
#'\emph{tmax_days90th} \tab Number of days with maximum temperature above the control period 90th percentile (hot days) \tab days \cr
#'\emph{tmin_days90th} \tab Number of days with minimum  temperature above the control period 90th percentile (warm nights) \tab days \cr
#'\emph{tmax_days10th} \tab Number of days with maximum temperature below the control period 10th percentile (cool days) \tab days \cr
#'\emph{tmin_days10th} \tab Number of days with minimum  temperature below the control period 10th percentile (cold nights) \tab days \cr
#'\emph{tmin_days0} \tab Number of days with minimum  temperature below 0 degrees Celsius \tab days \cr 
#'\emph{ppt_days} \tab Number of days with precipitation greater than 0.2 mm \tab days \cr 
#'\emph{ppt_days2} \tab Number of days with precipitation greater than 2 mm \tab days \cr 
#'\emph{ppt_days10} \tab Number of days with precipitation greater than 10 mm \tab days \cr 
#'\emph{ppt_days90th} \tab Number of days with precipitation greater than the control periods 90th percentile \tab days \cr 
#'\emph{ppt_dryspell} \tab Average number of days between precipitation events \tab days \cr 
#'\emph{ppt_means} \tab Average daily precipitation \tab mm 
#'}
#' @import plyr
#' @param locator The ISO3 country code that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID [1-468]
#' @param type the type of data you want "mavg" for monthly averages, "annualavg"
#' @param stat The statistics of interest, must be one of the ones listed above.
#' 
#' @examples \dontrun{
#'  ### Request data on the US for days of rain over 2 mm
#'  ens_dat <- get_ensemble_stats("USA","mavg","ppt_days2")
#'  # subset to the 50th percentile and just until the year 2100
#'  ens_dat <- subset(ens_dat, ens_dat$percentile == 50)
#'  ens_dat <- subset(ens_dat,ens_dat$toYear == 2100)
#'  ggplot(ens_dat,aes(x = as.factor(month), y= monthVals, group=scenario, 
#'  colour=scenario)) + geom_point() + geom_line()
#'}
#'@export


get_ensemble_stats <- function(locator, type, stat){
  ### check the stat is valid
  statvec <- c("tmin_means","tmax_means","tmax_days90th","tmin_days90th","tmax_days10th","tmin_days10th","tmin_days0","ppt_days","ppt_days2","ppt_days10","ppt_days90th","ppt_dryspell","ppt_means") 
  if(!stat%in%statvec){
    stop(paste("Please enter a valid statistic to retrieve.","Must be one of the following:",statvec, " see help for details",sep="  "))
  }
  
  ## Error handling for type.  
  typevec <- c("mavg","annualavg","manom","annualanom")
  if(!type%in%typevec){
    stop("Please enter a valid data type to retrieve, see help for details")
  }
  
  
  #Convert numeric basin numbers to strings if they were entered incorrectly
  locator <- as.character(locator)
  
  ## Error handling for location input
  geo_ref <- check_locator(locator)
  

  ### Set dates to retrieve both future scenarios.
  
  dates <- rbind(c(2046,2065),c(2081,2100))
  data_out <- list()
  counter <- 1
  for(i in 1:length(locator)){
    for(j in 1:length(dates[,1])){
      data_out[[counter]] <- get_ensemble_climate_data(locator[i],geo_ref,type,stat,dates[j,1],dates[j,2])
      counter <- counter + 1
    }
  }
  
  dat_out <- ldply(data_out,data.frame)
  ## Standardize dataframe name for data of interest
  
  if(grepl("ann",type)){
    to_rep <- "annualVal"
  } else { to_rep <- "monthVals"}
  colnames(dat_out)[which(colnames(dat_out)==to_rep)] <- "data"
  
  return(dat_out)
}
