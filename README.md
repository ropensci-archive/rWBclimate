`rWBclimate` Introduction 
========================================================
rWBclimate is an R interface for the World Bank climate data used in the World Bank [climate knowledge portal](http://sdwebx.worldbank.org/climateportal/index.cfm).  

Installation
------
Right now the package is only installable from github with [devtools](http://cran.r-project.org/web/packages/devtools/index.html):

```R
install.packages("devtools")
require(devtools)

install_github("rWBclimate", "ropensci")
require(rWBclimate)
```
Package description
----

`rWBclimate` provides access to three different classes of climate data at two different spatial scales.  The three different classes of data are GCM model , ensemble and historical data.  Each data class will let you download two different four different types for two different variables.  The two variables are either precipitation expressed in millimeters or temperature as degrees celcius, and for each variable you can download your data in one of four types. The data is fully described below along with examples.

Data classes
---
*__Model data__*

Almost all model data in the Climate Data API are derived from 15 global circulation models (GCMs) used by the Intergovernmental Panel on Climate Change (IPCC) 4th Assessment Reports. The models simulate the response of the global climate system to increasing greenhouse gas concentrations. The data in the Climate Data API have been aggregated to both the country and basin levels, as explained below. Note these data are modeled estimates of temperature and precipitation changes in different time periods under different GCMs and scenarios. They include changes for future time periods and also as “backcasting” (model representations of the past) set for past time periods. The latter should not be confused with any instrumental or observed data. There is a specific dataset with historical measured climate data as well.

**Data types**

|Type|Description|
|----|----|
|Monthly average|The monthly average for all 12 months for a given time period|
|Annual average|a single average for a given time period|
|Monthly anomaly|Average monthly change (anomaly).  The control period is 1961-1999 for temperature and precipitation variables, and 1961-2000 for derived statistics.|
|Annual anomaly|Average annual change (anomaly). The control period is 1961-1999 for temperature and precipitation variables, and 1961-2000 for derived statistics.|

**Data time scales**

Climate model data is only available as averages for 20 year chunks.  The package will automatically convert any start and end data into valid API calls and will return all data between the given start and end date.  The following time periods are available


|Past|     |Future|    |
|----|-----|------|----|
|*start*|  *end*  |  *start*  |*end*|
|1920  | 1939|  2020 | 2039 |
|1940 |  1959|  2040 |2059|
|1960 |   1979|  2060 |2079 |
|1980  | 1999| 2080 | 2099 |

**Data spatial scales**
Data is available at two spatial scales.  The first is country level. You can download data for any country in the world using a valid [ISO 3 letter country code](http://userpage.chemie.fu-berlin.de/diverse/doc/ISO_3166.html). Alternatively you can download data at the basin network for a slightly higher resolution represented as a number 1-468.  This is based on level 2 boundaries from [waterbase.org](http://www.waterbase.org), or you can view a [full map of all the available basins.](http://data.worldbank.org/sites/default/files/climate_data_api_basins.pdf)


**_Downloading GCM Model Data_**



