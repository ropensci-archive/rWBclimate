\name{basin_temp}
\alias{basin_temp}
\title{Function wraps get_wd_climate_data() and returns temperature data from GCM's in
degrees celcisus. The function is useful because it removes some of the complicated
parameters for the API and prevents bad calls.}
\usage{
  basin_temp(ID, type, start, end)
}
\arguments{
  \item{ID}{basin ID from
  http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf
  It can be just a single basin id, or a vector of ids.
  ids should be strings.}

  \item{type}{the type of data to retrieve, must be "mavg"
  for monthly averages, "annualavg" for annual averages,
  "manom" for monthly anomaly, and "annualanom" for annual
  anomaly.}

  \item{start}{the start year to gather data for.}

  \item{end}{the end year to gather data to.}
}
\value{
  a dataframe with data for all scenarios, gcms, for each
  time period and each basin ID in degrees celcius.
}
\description{
  Function wraps get_wd_climate_data() and returns
  temperature data from GCM's in degrees celcisus. The
  function is useful because it removes some of the
  complicated parameters for the API and prevents bad
  calls.
}
\details{
  start and end year can be any years, but all years will
  be coerced into periods outlined by the API
  (http://data.worldbank.org/developers/climate -data-api)
  anomaly periods are only valid for future scenarios and
  based on a reference period of 1969 - 1999, see API for
  full details.
}
\examples{
\dontrun{
# Get data for 2 basins, annual average temperature for all valid time periods
# then subset them, and plot
basin_dat <- basin_temp(c("2","231"),"annualavg",1900,3000)
basin_dat <- subset(basin_dat,basin_dat$gcm=="ukmo_hadcm3")
basin_dat <- subset(basin_dat,basin_dat$scenario!="b1")
ggplot(basin_dat,aes(x=fromYear,y=annualData,group=locator,colour=locator))+geom_path()

# get data from two basins and then plot by year period across months
basin_dat <- basin_temp(c("2","231"),"mavg",1900,3000)
basin_dat <- subset(basin_dat,basin_dat$gcm=="bccr_bcm2_0")
basin_dat <- subset(basin_dat,basin_dat$scenario!="b1")
basin_dat <- subset(basin_dat,basin_dat$locator == "2")
ggplot(basin_dat,aes(x=month,y=monthVals,group=as.factor(fromYear),colour=as.factor(fromYear)))+geom_point()+geom_path()
}
}

