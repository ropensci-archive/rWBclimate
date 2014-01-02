#'Convert kml to polygon
#'@description Create an sp SpatialPolygon or SpatialPolygonDataFrame object from a downloaded KML file and data file
#'@param map_df a map dataframe generated from create_map_df()
#'@param df a climate dataframe with one piece of data to be mapped to each unique spatial polygon.
#'@param crs_string Coordinate reference string to use in spatial projection.  Default is WSGS84.
#'@return a SpatialPolygon object
#'@details If a dataframe is included, a spatial polygon dataframe object is created.  The dataframe must have one unique piece of information per polygon, otherwise an error will be thrown.  However just a basic spatial polygon will be created if no dataframe is included.  
#'@import sp
#'@examples \dontrun{
#' sa_map <- create_map_df(locator=SoAm_country)
#' sa_dat <- get_ensemble_temp(SoAm_country,"annualanom",2080,2100)
#' sa_dat <- subset(sa_dat,sa_dat$scenario == "a2")
#' sa_dat <- subset(sa_dat,sa_dat$percentile == 50)
#' sa_poly <- kml_to_sp(sa_map,df = sa_dat)
#' ### colors are a bit off, but just to verify that data is 
#' spplot(sa_poly,"data")
#'
#'}
#'@export

kml_to_sp <- function(map_df, df = NULL, crs_string = "+proj=longlat +datum=WGS84"){
  
  
  
  ### Create polygons from groups
  uid <- unique(map_df$ID)
  uid_poly <- list()
  for(u in 1:length(uid)){
    
    ### subset data to work with 
    tmp_dat <- subset(map_df,map_df$ID == uid[u])
    ### Convert factors to numebrs
    tmp_dat$piece <- as.numeric(tmp_dat$piece)
    fid <- unique(tmp_dat$piece)
    poly_list <- list()
    for(i in fid){
      poly_list[[i]] <- Polygon(tmp_dat[which(tmp_dat$piece==i),1:2])
      }
    uid_poly[[u]] <- Polygons(poly_list, ID= uid[u])
    
  }
  
  out <- SpatialPolygons(uid_poly,1:length(uid),proj4string=CRS(crs_string))
  
  if(is.null(df)){
    return(out)
  }else{
    rownames(df) <- df$locator
    out <- SpatialPolygonsDataFrame(out,df)
    return(out)
  }
  
}