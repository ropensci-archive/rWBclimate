# Get data for one country, annual average temperature for all valid time periods
 #then subset them, and plot
 country_dat <- country_temp(c("USA","BRA"),"annualavg",1900,3000)
 country_dat <- subset(country_dat,country_dat$gcm=="ukmo_hadcm3")
 country_dat <- subset(country_dat,country_dat$scenario!="b1")
 ggplot(country_dat,aes(x=fromYear,y=annualData,group=locator,colour=locator))+geom_path()
