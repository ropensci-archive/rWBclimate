\name{kml_to_sp}
\alias{kml_to_sp}
\title{Convert to polygon}
\usage{
kml_to_sp(map_df, crs_string = "+proj=longlat +datum=WGS84")
}
\arguments{
  \item{map_df}{a map dataframe generated from
  create_map_df()}

  \item{crs_string}{Coordinate reference string to use in
  spatial projection.  Default is WSGS84.}
}
\value{
a SpatialPolygon object
}
\description{
Create an sp SpatialPolygon object from a downloaded KML
file
}
\details{
<add text here>
}
\examples{
\dontrun{}
}

