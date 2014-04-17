#'Download historical precipitation data
#'
#' @description The Climate Data API provides access to historical precipitation data. These data are separate from the outputs of the GCMs,
#' and they are based on gridded climatologies from the Climate Research Unit.
#' 
#' @import httr plyr
#' @param locator The ISO3 country code that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID [1-468]. This can be a vector of all basins or all countries.
#' @param time_scale The time scale you want to return values on.  Must be "\emph{month}", "\emph{year}" or "\emph{decade}"
#' @return a dataframe with historical precipitation data 
#' @details The historical period for country is 1901 - 2009, and 1960 - 2009 for basin. The time_scale parameter returns a different number of variables depending on the input timescale. \emph{Month} will return 12 values, a historical average for that month across all years.  \emph{Year} will return yearly averages for each year, and \emph{decade} will return decade averages.
#' 
#' @examples \dontrun{
#' ## Plot annual historical data for USA, Brazil and Australia
#' hist_dat <- get_historical_precip(c("USA","BRA","AUS"),"year")
#' ggplot(hist_dat,aes(x = year,y = data, group = locator,
#' colour = locator)) + geom_point() + geom_path() + ylab("Mean annual precipitaion")
#'
#' ## Plot monthly historical data
#' hist_mo_dat <- get_historical_precip(c("USA","AUS","BRA","IDN"),time_scale="month")
#' ggplot(hist_mo_dat,aes(x = month,y = data, group = locator,
#' colour = locator)) + geom_point() + geom_path() + ylab("Mean monthly precipitaion")
#' 
#' }
#' @export

get_historical_precip <- function(locator,time_scale){
  cvar <- "pr"
  return(get_historical_data_recursive(locator,cvar,time_scale))
}
