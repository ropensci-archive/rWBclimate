\name{kml_to_sp}
\alias{kml_to_sp}
\title{Convert kml to polygon}
\usage{
  kml_to_sp(map_df, df = NULL,
    crs_string = "+proj=longlat +datum=WGS84")
}
\arguments{
  \item{map_df}{a map dataframe generated from
  create_map_df()}

  \item{df}{a climate dataframe with one piece of data to
  be mapped to each unique spatial polygon.}

  \item{crs_string}{Coordinate reference string to use in
  spatial projection.  Default is WSGS84.}
}
\value{
  a SpatialPolygon object
}
\description{
  Create an sp SpatialPolygon or SpatialPolygonDataFrame
  object from a downloaded KML file and data file
}
\details{
  If a dataframe is included, a spatial polygon dataframe
  object is created.  The dataframe must have one unique
  piece of information per polygon, otherwise an error will
  be thrown.  However just a basic spatial polygon will be
  created if no dataframe is included.
}
\examples{
\dontrun{
sa_map <- create_map_df(locator=SoAm_country)
sa_dat <- get_ensemble_temp(SoAm_country,"annualanom",2080,2100)
sa_dat <- subset(sa_dat,sa_dat$scenario == "a2")
sa_dat <- subset(sa_dat,sa_dat$percentile == 50)
sa_poly <- kml_to_sp(sa_map,df = sa_dat)
### colors are a bit off, but just to verify that data is
spplot(sa_poly,"data")

}
}

