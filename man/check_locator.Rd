\name{check_locator}
\alias{check_locator}
\title{Checks for what kind of locator a user input}
\usage{
  check_locator(locator)
}
\arguments{
  \item{locator}{The ISO3 country code that you want data
  about.
  (http://unstats.un.org/unsd/methods/m49/m49alpha.htm) or
  the basin ID [1-468]}
}
\value{
  geo_ref a string indicating what kind of geography to use
  in the api
}
\description{
  Checks for what kind of locator a user input
}

