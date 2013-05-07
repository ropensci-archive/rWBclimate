#' Downloads map data from in kml format and writes it to a temporary directory.  You must specify a temporary directory to write files to in your options.  
#' 
#' @import httr
#' @param locator The a vector of ISO3 country code's that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID's [1-468] (http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf)
#' @param resolution The optional simplification value is a decimal value between 0 and 1 that specifies boundary resolution; 0 (the default) is the highest available resolution while 1 is the lowest. This option lets you request simpler and thus smaller boundaries at the expense of resolution. A value of 0.01 reduces output and complexity by roughly 50%; values above 0.05 begin to lose too much detail.
#' @details kml files can be quite large making downloading them every time you want to make a map time consuming.  To 
#' reduce this time it's easiest to download kml files and store them.  To set the directory use a line like this: \code{options(kmlpath="/Users/emh/kmltemp")}  The option must be called "kmlpath".
#' 
#' @export

download_kml <- function(locator, resolution = 0){
  if(is.null(getOption("kmlpath"))){stop("You must first set the kmlpath parameter in options, see help for details.")}
  #get vector of file names.
  my_path <- getOption("kmlpath")
  last_char <- substr(my_path,nchar(my_path),nchar(my_path))
  if(last_char != "/"){my_path <- paste(my_path,"/",sep="")}
  #get vector of KML files in kml path and strip them of their extension
  kml_files <- gsub(".kml","",list.files(my_path,"kml"))
  
  #Convert numeric basin numbers to strings if they were entered incorrectly
  resolution <- as.character(resolution)
  locator <- as.character(locator)
  locator <- toupper(locator)
  geo_ref <- check_locator(locator)
  
  #check which kml are already downloaded
  to_download <- locator[!locator%in%kml_files]
  base_url <- "http://climatedataapi.worldbank.org/climateweb/rest/v1"
  
  ###Loop through downloading each file and writing it.
  if(length(to_download) > 0){
   for(i in 1:length(to_download)){
      full_url <- paste(base_url,geo_ref,"kml",resolution,to_download[i],sep="/")
      temp_file <- content(GET(url=full_url),as="text")
      ###Write file
      to_write<- file(paste(my_path,to_download[i],".kml",sep=""),open="w")
      writeLines(temp_file,to_write)
      close(to_write)
   }
  }
  
 
} 

