`rWBclimate` Introduction 
========================================================
rWBclimate is an R interface for the World Bank climate data used in the World Bank [climate knowledge portal](http://sdwebx.worldbank.org/climateportal/index.cfm).  

Installation
------
Right now the package is only installable from github.

It provides three different kinds of climate data at two different spatial scales.  The three different classes of data are historical, ensemble and model.  Each data class will let you download two different four different types for two different variables.  The two variables are either precipitation expressed in millimeters or temperature as degrees celcius, and for each variable you can download your data in one of four types. The data is fully described below along with examples. Much of the text 

Data classes
---
*__Model data__
  *Except as noted, all the data in the Climate Data API are derived from 15 global circulation models (GCMs) used by the Intergovernmental Panel on Climate Change (IPCC) 4th Assessment Reports. The models simulate the response of the global climate system to increasing greenhouse gas concentrations. The data in the Climate Data API have been aggregated to both the country and basin levels, as explained below. Note these data are modeled estimates of temperature and precipitation changes in different time periods under different GCMs and scenarios. They include changes for future time periods and also as “backcasting” (model representations of the past) set for past time periods. The latter should not be confused with any instrumental or observed data. There is a specific dataset with historical measured climate data as well.


|Type|Description|
|----|----|
|Monthly average|The monthly average for all 12 months for a given time period|
|Annual average|a single average for a given time period|
|Monthly anomaly|Average monthly change (anomaly).  The control period is 1961-1999 for temperature and precipitation variables, and 1961-2000 for derived statistics.|
|Annual anomaly|Average annual change (anomaly). The control period is 1961-1999 for temperature and precipitation variables, and 1961-2000 for derived statistics.|




Past
start  end
1920
1939
1940
1959
1960
1979
1980
1999
Future
start	end
2020
2039
2040
2059
2060
2079
2080
2099