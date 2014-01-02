\name{create_map_df}
\alias{create_map_df}
\title{Create mapable dataframe}
\usage{
create_map_df(locator, resolution = 0.007)
}
\arguments{
  \item{locator}{The a vector of ISO3 country code's that
  you want data about.
  (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or
  the basin ID's [1-468]
  (http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf)}

  \item{resolution}{The optional simplification value is a
  decimal value between 0 and 1 that specifies boundary
  resolution; 0 (the default) is the highest available
  resolution while 1 is the lowest. This option lets you
  request simpler and thus smaller boundaries at the
  expense of resolution. A value of 0.01 reduces output and
  complexity by roughly 50%; values above 0.05 begin to
  lose too much detail. Also values above 0.5 also tend to
  be empty for small basin regions throwing an error when
  loding KML data.}
}
\description{
A function that will download maps for a vector of basins
or country codes and return a data frame that has the kml
output processed such that it can be plotted with ggplot2
and other mapping functions:
}
\details{
kml files can be quite large (100k-600k per country) making
downloading them every time you want to make a map time
consuming.  To reduce this time it's easiest to download
kml files and store them.  To set the directory use a line
like this: \code{options(kmlpath="/Users/emh/kmltemp")} The
option must be called "kmlpath".  These files will be
persistent until you delete them.
}
\examples{
\dontrun{
to_map <- create_map_df(c("USA","MEX","CAN"))
ggplot(to_map, aes(x=long, y=lat,group=group))+ geom_polygon()
}
}

