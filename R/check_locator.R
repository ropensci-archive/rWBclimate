#' Checks for what kind of locator a user input
#' @param locator The ISO3 country code that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID [1-468]
#' @return geo_ref a string indicating what kind of geography to use in the api


check_locator <- function(locator){

  locator_check <- suppressWarnings( sum(is.na(as.numeric(locator))))
  if( locator_check == 0){
    geo_ref <- "basin"
  } else
    if(locator_check == length(locator)){
      geo_ref <- "country"
    } else {
      stop("You must enter either basin ID numbers or country codes, but not a mixed vector of both")
    }
  return(geo_ref)
}