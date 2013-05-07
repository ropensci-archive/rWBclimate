\name{get_ensemble_climate_data}
\alias{get_ensemble_climate_data}
\title{Download ensemble data for all models, returns the 10th, 50th and 90th percentile
of all models (15 for A1, 13 for B2).  Ensemble requets can be for countries
or basins.}
\usage{
  get_ensemble_climate_data(locator, geo_type, type, cvar,
    start, end)
}
\arguments{
  \item{locator}{The ISO3 country code that you want data
  about.
  (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or
  the basin ID [1-468]}

  \item{geo_type}{basin or country depending on the locator
  type}

  \item{type}{the type of data you want "mavg" for monthly
  averages, "annualavg"}

  \item{cvar}{The variable you're interested in. "pr" for
  precipitation, "tas" for temperature in celcius.}

  \item{start}{The starting year you want data for, can be
  in the past or the future. Must conform to the periods
  outlined in the world bank API.  If given values don't
  conform to dates, the fuction will automatically round
  them.}

  \item{end}{The ending year you want data for, can be in
  the past or the future.  Similar to the start date, dates
  will be rounded to the nearest end dat.}
}
\description{
  Download ensemble data for all models, returns the 10th,
  50th and 90th percentile of all models (15 for A1, 13 for
  B2).  Ensemble requets can be for countries or basins.
}

