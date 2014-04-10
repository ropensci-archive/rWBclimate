#'Download historical climate data recursively 
#'
#' @description Recursively get historical data
#' @import httr plyr
#' @param locator The ISO3 country code that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID [1-468].
#' The historical period for country is 1901 - 2009, and 1960 - 2009 for basin 
#' @param cvar The climate variable you're interested in. "\emph{pr}" for precipitation, "\emph{tas}" for temperature in celcius.
#' @param time_scale The time scale you want to return values on.  Must be "\emph{month}", "\emph{year}" or "\emph{decade}"
#' @return a dataframe with historical climate data 
#' @details The time_scale parameter returns a different number of variables depending on the input timescale. \emph{Month} will return 12 values, a historical average for that month across all years.  \emph{Year} will return yearly averages for each year, and \emph{decade} will return decade averages.
get_historical_data_recursive <- function(locator,cvar,time_scale){
data_out <- list()
counter <- 1
for(i in 1:length(locator)){
    data_out[[i]] <- get_historical_data(locator[i],cvar,time_scale)
}

dat_out <- ldply(data_out,data.frame)
return(dat_out)
}
