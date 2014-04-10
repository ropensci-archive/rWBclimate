#'Create mapable dataframe
#'@description A function that will download maps for a vector of basins or country codes and return a data frame that has the kml output processed such that it can be plotted with ggplot2 and other mapping functions:
#' 
#' @import httr rgdal ggplot2 plyr
#' @importFrom utils txtProgressBar setTxtProgressBar
#' @param locator The a vector of ISO3 country code's that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID's [1-468] (http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf)
#' @details kml files can be quite large (100k-600k per country) making downloading them every time you want to make a map time consuming.  To 
#' reduce this time it's easiest to download kml files and store them.  To set the directory use a line like this: \code{options(kmlpath="/Users/emh/kmltemp")}  The option must be called "kmlpath".  These files will be persistent until you delete them.
#'@examples \dontrun{
#' to_map <- create_map_df(c("USA","MEX","CAN"))
#' ggplot(to_map, aes(x=long, y=lat,group=group))+ geom_polygon()
#'}
#' 
#' @export
create_map_df <- function(locator) {
  ### First just download all the maps 
  ### All error handling is done in the download_kml()
  locator <- as.character(locator)
  locator <- toupper(locator)
  download_kml(locator)

  
  my_path <- path.expand(getOption("kmlpath"))
  last_char <- substr(my_path, nchar(my_path), nchar(my_path))
  if(last_char != "/"){my_path <- paste(my_path, "/", sep="")}
  #get vector of KML files in kml path and strip them of their extension
  kml_files <- gsub(".kml", "", list.files(my_path, "kml"))
  to_plot <- kml_files[kml_files%in%locator]
  
  df_out <- list()
    map_pb <- txtProgressBar(min = 0, max = length(locator), style = 3)
  for(i in 1:length(locator)) {
    fName <- paste(my_path,to_plot[i], ".kml", sep = "")
    fSize <- file.info(fName)$size
    ### Throw an error if your file is too small
    if(fSize < 200) {
      stop(paste("A map file for ", to_plot[i], "contains no data, please set the resolution parameter closer to 0 or remove it from your list of maps to download"))
    }
    
    my_layer <- ogrListLayers(fName)
    kml_tmp <- readOGR(paste(my_path, to_plot[i], ".kml", sep = ""),layer = my_layer[1], verbose = F)
    kml_f <- suppressMessages(fortify(kml_tmp))
    kml_f$group <- paste(kml_f$group, to_plot[i], sep = "-")
    kml_f$ID <- to_plot[i]
    df_out[[i]] <- kml_f
    setTxtProgressBar(map_pb, i)
    
  }
    close(map_pb)
   return(ldply(df_out, data.frame))
}

