#'Download climate data
#'
#'@description Download monthly average climate data from the world bank climate 
#'             data api. Ideally you'll want to use the wrapper functions that call this.
#' 
#' @import httr plyr
#' @param locator The ISO3 country code that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID [1-468]
#' @param geo_type basin or country depending on the locator type
#' @param type the type of data you want "mavg" for monthly averages, "annualavg"
#' @param cvar The variable you're interested in. "pr" for precipitation, "tas" for temperature in celcius.
#' @param start The starting year you want data for, can be in the past or the future. Must conform to the periods outlined in the world bank API.  If given values don't conform to dates, the fuction will automatically round them.
#' @param end The ending year you want data for, can be in the past or the future.  Similar to the start date, dates will be rounded to the nearest end dat.  
#' @export
#' 

get_climate_data <- function(locator,geo_type,type, cvar, start, end){
  base_url <- "http://climatedataapi.worldbank.org/climateweb/rest/v1/"
  
  ### Error handling
  if(geo_type == "country"){
    check_ISO_code(country)
  }
 
  if(geo_type == "basin"){
    if(is.na(as.numeric(locator))){
      stop("You must enter a valid Basin number between 1 and 468")
    }
    if(as.numeric(locator) < 1 || as.numeric(locator) > 468){
      as.numeric(locator) < 1 || as.numeric(locator) > 468
    }
      
    
  }
  
  data_url <- paste(geo_type,type,cvar,start,end,locator,sep="/")
  extension <- ".json"
  full_url <- paste(base_url,data_url,extension,sep="")
  parsed_data <- content(GET(full_url),as="parsed")
  data_out <- ldply(parsed_data,data.frame)
  if( type == "mavg"){
    data_out$month  <- rep(1:12,dim(data_out)[1]/12)
  }
  
  if(start < 2010){
    tmp_names <- c("scenario",colnames(data_out))
    data_out <- cbind(rep("past",dim(data_out)[1]),data_out)
    colnames(data_out)<- tmp_names
    
  }
  
  data_out$locator <- rep(locator,dim(data_out)[1])
  
  return(data_out)
}

