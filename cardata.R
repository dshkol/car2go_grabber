require(RJSONIO)
url<-"https://www.car2go.com/api/v2.1/vehicles?loc='yourcity'&oauth_consumer_key='yourkey'=json"
json_data<-fromJSON(paste(readLines(url),collapse=""))
max<-length(json_data$placemarks)

name<-unlist(lapply(json_data$placemarks,'[[',name='name'))
vin<-unlist(lapply(json_data$placemarks,'[[',name='vin'))
address<-unlist(lapply(json_data$placemarks,'[[',name='address'))
fuel<-unlist(lapply(json_data$placemarks,'[[',name='fuel'))
engineType<-unlist(lapply(json_data$placemarks,'[[',name='engineType'))
interior<-unlist(lapply(json_data$placemarks,'[[',name='interior'))
exterior<-unlist(lapply(json_data$placemarks,'[[',name='exterior'))
coordinates<-lapply(json_data$placemarks,'[[',name='coordinates')
cvect<-unlist(coordinates)
lat<-subset(cvect,cvect<0)
lon<-subset(cvect,cvect>0)

date<-as.Date(Sys.time()) #R date format
date[1:max]<-date
datestr<-format(Sys.time(), "%Y-%m-%d") #character time
datestr[1:max]<-datestr
timestr<-format(Sys.time(), "%H:%M:%S") #character time
timestr[1:max]<-timestr
#posixt<-unlist(strptime(timestr, format="%H:%M:%S")) #to also have time in POSIX standard

cardata<-data.frame(cbind(date,datestr,timestr,vin,name,lat,lon,address,fuel,engineType,exterior,interior))
write.table(cardata,file="cardata.csv",append=T,sep=",",col.names=F)