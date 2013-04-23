\name{country_precip}
\alias{country_precip}
\title{Function wraps get_wd_climate_data() and returns temperature data from GCM's in
degrees celcisus. The function is useful because it removes some of the complicated
parameters for the API and prevents bad calls.}
\usage{
  country_precip(country, type, start, end)
}
\arguments{
  \item{country}{Valid 3 letter ISO3 Country code from
  http://unstats.un.org/unsd/methods/m49/m49alpha.htm It
  can be just a single country code, or a vector of country
  codes.}

  \item{type}{the type of data to retrieve, must be "mavg"
  for monthly averages, "annualavg" for annual averages,
  "manom" for monthly anomaly, and "annualanom" for annual
  anomaly.}

  \item{start}{the start year to gather data for.}

  \item{end}{the end year to gather data to.}
}
\value{
  a dataframe with data for all scenarios, gcms, for each
  time period and each country, returned as the average
  annual or monthly amount of precipitation in mm
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
# Get data for 2 countries, annual average temperature for all valid time periods
#then subset them, and plot
country_dat <- country_precip(c("USA","BRA"),"annualavg",1900,3000)
country_dat <- subset(country_dat,country_dat$gcm=="ukmo_hadcm3")
country_dat <- subset(country_dat,country_dat$scenario!="b1")
ggplot(country_dat,aes(x=fromYear,y=annualData,group=locator,colour=locator))+geom_path()
}

