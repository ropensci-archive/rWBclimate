\name{get_model_temp}
\alias{get_model_temp}
\title{Download GCM temperature data}
\usage{
get_model_temp(locator, type, start, end)
}
\arguments{
  \item{locator}{A vector of either watershed basin ID's
  from
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
a dataframe with temperature predictions in degrees C for
all scenarios, gcms, for each time period.
}
\description{
Function wraps get_climate_data() and returns temperature
by basin or country in degrees C as output from all 15
models, for the a1 and b2 scenarios.
}
\details{
start and end year can be any years, but all years will be
coerced into periods outlined by the API
(http://data.worldbank.org/developers/climate -data-api)
anomaly periods are only valid for future scenarios and
based on a reference period of 1969 - 1999, see API for
full details.
}
\examples{
\dontrun{
# Get data for 2 basins, annual average temperature for all valid time periods
# then subset them, and plot
temp_dat <- get_model_temp(c("2","231"),"annualavg",1900,3000)
temp_dat <- subset(temp_dat,temp_dat$gcm=="ukmo_hadcm3")
temp_dat <- subset(temp_dat,temp_dat$scenario!="b1")
ggplot(temp_dat,aes(x=fromYear,y=data,group=locator,
colour=locator))+geom_path()

### Get data for 4 countries with monthly tempitation values
temp_dat <- get_model_temp(c("USA","BRA","CAN","YEM"),"mavg",2020,2030)
temp_dat <- subset(temp_dat,temp_dat$gcm=="ukmo_hadcm3")
temp_dat <- subset(temp_dat,temp_dat$scenario!="b1")
ggplot(temp_dat,aes(x=as.factor(month),y=data,group=locator,
colour=locator))+geom_path()
}
}

