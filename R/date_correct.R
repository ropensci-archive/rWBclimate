#'correct data values
#'@description Round start and end dates to conform with data api standards.  See api documentation (http://data.worldbank.org/developers/climate-data-api)
#'for full details
#'
#'@param start The start year
#'@param end The end year
#'@return a 2xM matrix where M in the number of periods in the data api
#'@examples \dontrun{
#'date_correct(1921,1957)
#'}


date_correct <- function(start, end){
  #basic error handling of user input
  if(length(start) > 1 || length(end) > 1){
    stop("Please input a single start and end date")
  }
  if(!is.numeric(start) || !is.numeric(end)){
    stop("Please input dates as numbers not strings")
  }
  
  #Handle constraints
  if(start <= 1920){ start <- 1920}
  if(start > 2080){start <- 2080}
  if(start > 1999 && start < 2020 ) {start <- 2020}
  
  if(end >= 2099){end <- 2099}
  if(end < 1939){end <- 1939}
  
  #2 matrices just for clarities sake
  past <- matrix(c(1920,1939,1940,1959,1960,1979,1980,1999),nrow=4,ncol=2,byrow=T)
  future <- matrix(c(2020,2039,2040,2059,2060,2079,2080,2099),nrow=4,ncol=2,byrow=T)
  time_periods <- rbind(past,future)
  
# Control for in and out of period
  if(start%in%time_periods[,1]){
    lb <- which(time_periods[,1] >= start)[1]
  } else {
    lb <- which(time_periods[,1] >= start)[1] - 1
    }

  if(end%in%time_periods[,2]){
    ub <- tail(which(time_periods[,2] <= end),n=1)
  } else {
    ub <- tail(which(time_periods[,2] <= end),n=1) + 1
  }  
  time_out <- time_periods[lb:ub,]
  if(length(time_out) == 2){time_out <- t(as.matrix(time_out))}
  return(time_out)  
}

