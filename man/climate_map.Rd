\name{climate_map}
\alias{climate_map}
\title{Map climate data}
\usage{
climate_map(map_df, data_df, return_map = TRUE)
}
\arguments{
  \item{map_df}{a map dataframe generated from
  create_map_df()}

  \item{data_df}{a climate dataframe with one piece of data
  to be mapped to each unique spatial polygon.}

  \item{return_map}{True returns a ggplot2 object, False
  returns a dataframe where data items are matched to their
  polygon that you can plot later on.}
}
\value{
Either a ggplot2 map or a dataframe depending on the
parameter return_map
}
\description{
Create maps of climate data.  It requires two data inputs,
a map dataframe, and a climate dataframe.  The climate data
must have one data point per spatial mapping point,e.g. 1
data point per country or basin being mapped.
}
\examples{
\dontrun{
#Set the kmlpath option
options(kmlpath = "/Users/edmundhart/kmltemp")
##Here we use a list basins for Africa
af_basin <- create_map_df(Africa_basin)
af_basin_dat <- get_ensemble_temp(Africa_basin,"annualanom",2080,2100)
##  Subset data to just one scenario, and one percentile
af_basin_dat <- subset(af_basin_dat,af_basin_dat$scenario == "a2")
af_basin_dat <- subset(af_basin_dat,af_basin_dat$percentile == 50)
af_map <- climate_map(af_basin,af_basin_dat,return_map = T)
af_map + scale_fill_continuous("Temperature \\n anomaly",low="yellow",high = "red") + theme_bw()

}
}

