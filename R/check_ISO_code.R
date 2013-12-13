#'check country codes
#'@description Checks if the country code entered is a valid country code that data exists for
#'
#'@param iso The 3 letter country code based on ISO3 Country abbreviations (http://unstats.un.org/unsd/methods/m49/m49alpha.htm)
#'@return TRUE if a valid code, otherwise an error is returned
#'@examples \dontrun{
#'check_ISO_code("USA")
#'}
#'



check_ISO_code <- function(iso){
codes <- c(NoAm_country,SoAm_country,Oceana_country,Africa_country,Asia_country,Eur_country)
  if(nchar(iso) != 3 && is.character(iso)){stop("Please enter a valid 3 letter country code")}
  if(is.numeric(iso)){stop("Please enter a 3 letter code, not a number")}
  if(!toupper(iso)%in%codes){stop(paste(iso,"is an invalid 3 letter country code, please refer to http://unstats.un.org/unsd/methods/m49/m49alpha.htm for a valid list",sep=" "))}
  return(TRUE)
}

