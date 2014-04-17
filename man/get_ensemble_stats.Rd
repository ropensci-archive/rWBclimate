\name{get_ensemble_stats}
\alias{get_ensemble_stats}
\title{Download ensemble statistics}
\usage{
get_ensemble_stats(locator, type, stat)
}
\arguments{
  \item{locator}{The ISO3 country code that you want data
  about.
  (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or
  the basin ID [1-468]}

  \item{type}{the type of data you want "mavg" for monthly
  averages, "annualavg"}

  \item{stat}{The statistics of interest, must be one of
  the ones listed above.}
}
\description{
Statistics can be from either two time periods: 2046 - 2065
and 2081 - 2100 and are all given in units relative to a
control period: 1961 - 2000.  Derived statistics can be any
of the following:

\tabular{lll}{ \strong{Statistic} \tab \strong{Description}
\tab \strong{Units} \cr \emph{tmin_means} \tab Average
daily minimum temperature \tab degrees Celsius \cr
\emph{tmax_means} \tab Average daily maximum temperature
\tab degrees Celsius \cr \emph{tmax_days90th} \tab Number
of days with maximum temperature above the control period
90th percentile (hot days) \tab days \cr
\emph{tmin_days90th} \tab Number of days with minimum
temperature above the control period 90th percentile (warm
nights) \tab days \cr \emph{tmax_days10th} \tab Number of
days with maximum temperature below the control period 10th
percentile (cool days) \tab days \cr \emph{tmin_days10th}
\tab Number of days with minimum temperature below the
control period 10th percentile (cold nights) \tab days \cr
\emph{tmin_days0} \tab Number of days with minimum
temperature below 0 degrees Celsius \tab days \cr
\emph{ppt_days} \tab Number of days with precipitation
greater than 0.2 mm \tab days \cr \emph{ppt_days2} \tab
Number of days with precipitation greater than 2 mm \tab
days \cr \emph{ppt_days10} \tab Number of days with
precipitation greater than 10 mm \tab days \cr
\emph{ppt_days90th} \tab Number of days with precipitation
greater than the control periods 90th percentile \tab days
\cr \emph{ppt_dryspell} \tab Average number of days between
precipitation events \tab days \cr \emph{ppt_means} \tab
Average daily precipitation \tab mm }
}
\examples{
\dontrun{
 ### Request data on the US for days of rain over 2 mm
 ens_dat <- get_ensemble_stats("USA","mavg","ppt_days2")
 # subset to the 50th percentile and just until the year 2100
 ens_dat <- subset(ens_dat, ens_dat$percentile == 50)
 ens_dat <- subset(ens_dat,ens_dat$toYear == 2100)
 ggplot(ens_dat,aes(x = as.factor(month), y= monthVals, group=scenario,
 colour=scenario)) + geom_point() + geom_line()
}
}

