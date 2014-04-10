#'wratpper for get_climate_data()
#'
#'@description Function to recursively call the get_climate_data().  Handles a vector of basins
#'or countries as well as multiple dates.
#'
#' @import plyr
#' @param locator The ISO3 country code that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID [1-468]
#' @param geo_type basin or country depending on the locator type
#' @param type the type of data you want "mavg" for monthly averages, "annualavg"
#' @param cvar The variable you're interested in. "pr" for precipitation, "tas" for temperature in celcius.
#' @param start The starting year you want data for, can be in the past or the future. Must conform to the periods outlined in the world bank API.  If given values don't conform to dates, the fuction will automatically round them.
#' @param end The ending year you want data for, can be in the past or the future.  Similar to the start date, dates will be rounded to the nearest end dat.
#' @examples \dontrun{
#'  get_ensemble_data_recursive(c("1","2"),"basin","mavg","pr",1920,1940)
#'}
#'@export



get_data_recursive <- function(locator,geo_type,type, cvar, start, end){
  dates <- date_correct(start,end)
  data_out <- list()
  counter <- 1
  for(i in 1:length(locator)){
    for(j in 1:length(dates[,1])){
      data_out[[counter]] <- get_climate_data(locator[i],geo_type,type,cvar,dates[j,1],dates[j,2])
      counter <- counter + 1
    }
  }
  
  dat_out <-ldply(data_out,data.frame)
  dat_out <- do.call(rbind,data_out)
  
  if(grepl("ann",type)){
    to_rep <- "annualData"
    ### Because of the new parsing methods data values come back as a list.  This will unlist them and flatten them out
    dat_out$annualData <- unlist(dat_out$annualData)
  } else { to_rep <- "monthVals"}
  
  colnames(dat_out)[which(colnames(dat_out)==to_rep)] <- "data"
  
  return(dat_out)
  
}
