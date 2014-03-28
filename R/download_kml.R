#'Download kml files
#'
#'@description Downloads map data from in kml format and writes it to a temporary directory.  You must specify a temporary directory to write files to in your options.  
#' 
#' @import httr
#' @importFrom utils txtProgressBar setTxtProgressBar
#' @param locator The a vector of ISO3 country code's that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID's [1-468] (http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf)
#' @details kml files can be quite large making downloading them every time you want to make a map time consuming.  To 
#' reduce this time it's easiest to download kml files and store them.  To set the directory use a line like this: \code{options(kmlpath="/Users/emh/kmltemp")}  The option must be called "kmlpath".
download_kml <- function(locator) {
  if(is.null(getOption("kmlpath"))){stop("You must first set the kmlpath parameter in options, see help for details.")}
  #get vector of file names.
  my_path <- getOption("kmlpath")
  last_char <- substr(my_path, nchar(my_path), nchar(my_path))
  if(last_char != "/") { my_path <- paste(my_path, "/", sep = "") }
  #get vector of KML files in kml path and strip them of their extension
  kml_files <- gsub(".kml","", list.files(my_path, "kml"))
  
  #Convert numeric basin numbers to strings if they were entered incorrectly
    locator <- as.character(locator)
  locator <- toupper(locator)
  geo_ref <- check_locator(locator)
  
  #check which kml are already downloaded
  to_download <- locator[!locator%in%kml_files]
  base_url <- "http://api.worldbank.org/climateweb/rest/v1"
  
  if(length(to_download) > 0){
    download_pb <- txtProgressBar(min = 0, max = length(to_download), style = 3)
 
  ###Loop through downloading each file and writing it.
  
   for(i in 1:length(to_download)) {
      full_url <- paste(base_url, geo_ref, "kml", to_download[i], sep="/")
      temp_file <- content(GET(url = full_url), as = "text")
      ###Write file
      to_write<- file(paste(my_path,to_download[i], ".kml", sep=""), open = "w")
      writeLines(temp_file,to_write)
      close(to_write)
      setTxtProgressBar(download_pb, i)
   }
  
  close(download_pb)
  }
} 

