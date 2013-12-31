#'Convert to polygon
#'@description Create an sp SpatialPolygon object from a downloaded KML file
#'@param map_df a map dataframe generated from create_map_df()
#'@param crs_string Coordinate reference string to use in spatial projection.  Default is WSGS84.
#'@return a SpatialPolygon object
#'@details <add text here>
#'@examples \dontrun{}
#'

kml_to_sp <- function(map_df,crs_string = "+proj=longlat +datum=WGS84"){
  
  
  
  ### Create polygons from groups
  uid <- unique(map_df$ID)
  for(u in uid){
    
    
  }
  
  
}