#'Checks if the country code entered is a valid country code that data exists for
#'
#'@param iso The 3 letter country code based on ISO3 Country abbreviations (http://unstats.un.org/unsd/methods/m49/m49alpha.htm)
#'@return TRUE if a valid code, otherwise an error is returned
#'@examples \dontrun{
#'check_ISO_code("USA")
#'}
#'
#'@export


check_ISO_code <- function(iso){
  # codes <- read.csv("data/isocodes.csv",header=F)
  if(exists(as.character(substitute(codes)))==TRUE){ NULL } else
    { data(codes); message("loaded codes") }
  
  codes <- as.vector(codes[,1])
  if(nchar(iso) != 3 && is.character(iso)){stop("Please enter a valid 3 letter country code")}
  if(is.numeric(iso)){stop("Please enter a 3 letter code, not a number")}
  if(!toupper(iso)%in%codes){stop("You have entered an invalid 3 letter country code, please refer to http://unstats.un.org/unsd/methods/m49/m49alpha.htm for a valid list")}
  return(TRUE)
}