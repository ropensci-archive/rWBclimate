#'Create mapable dataframe
#'@description A function that will download maps for a vector of basins or country codes and return a data frame that has the kml output processed such that it can be plotted with ggplot2 and other mapping functions:
#' 
#' @import httr rgdal ggplot2 plyr
#' @param locator The a vector of ISO3 country code's that you want data about. (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or the basin ID's [1-468] (http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf)
#' @param resolution The optional simplification value is a decimal value between 0 and 1 that specifies boundary resolution; 0 (the default) is the highest available resolution while 1 is the lowest. This option lets you request simpler and thus smaller boundaries at the expense of resolution. A value of 0.01 reduces output and complexity by roughly 50%; values above 0.05 begin to lose too much detail.
#' @details kml files can be quite large (100k-600k per country) making downloading them every time you want to make a map time consuming.  To 
#' reduce this time it's easiest to download kml files and store them.  To set the directory use a line like this: \code{options(kmlpath="/Users/emh/kmltemp")}  The option must be called "kmlpath".  These files will be persistent until you delete them.
#'@examples \dontrun{
#' to_map <- create_map_df(c("USA","MEX","CAN"))
#' ggplot(to_map, aes(x=long, y=lat,group=group))+ geom_polygon()
#'}
#' 
#' @export

create_map_df <- function(locator,resolution = 0){
  ### First just download all the maps 
  ### All error handling is done in the download_kml()
  locator <- as.character(locator)
  locator <- toupper(locator)
  download_kml(locator,resolution)

  
  my_path <- getOption("kmlpath")
  last_char <- substr(my_path,nchar(my_path),nchar(my_path))
  if(last_char != "/"){my_path <- paste(my_path,"/",sep="")}
  #get vector of KML files in kml path and strip them of their extension
  kml_files <- gsub(".kml","",list.files(my_path,"kml"))
  to_plot <- kml_files[kml_files%in%locator]
  
  df_out <- list()
  
  for(i in 1:length(locator)){
    my_layer <- ogrListLayers(paste(my_path,to_plot[i],".kml",sep=""))
    kml_tmp <- readOGR(paste(my_path,to_plot[i],".kml",sep=""),layer=my_layer[1])
    kml_f <- fortify(kml_tmp)
    kml_f$group <- paste(kml_f$group,to_plot[i],sep="-")
    kml_f$ID <- to_plot[i]
    df_out[[i]] <- kml_f
  }
  
   return(ldply(df_out,data.frame))
}

