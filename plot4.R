##downloading the data and unzipping

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f<-file.path(getwd(),"hopoco.zip")
download.file(url,f)
unzip(f,exdir = getwd())

##Reading data into R
fp=file.path(getwd(),"hopowcon.txt")
houpowcon<-read.table(text=grep("^[1,2]/2/2007",readLines(fp),value = TRUE),sep=';',col.names =c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

##Creating energy submeter plot
  ##formating date and time
houpowcon$Date <- as.Date(houpowcon$Date, format = 'dd/mm/YYYY')
houpowcon$DateTime <- strptime(paste(houpowcon$Date, houpowcon$Time),format = "%Y-%m-%d %H:%M:%S",tz="")
png(filename = "./plot4.png",width = 480,height = 480,units = "px")
##setting window for ploting graph
par(mfrow=c(2,2))

##global active power
with(houpowcon,plot(houpowcon$DateTime, houpowcon$Global_active_power, xlab = '', ylab = 'Global Active Power', type = 'l'))

##voltage
with(houpowcon,plot(houpowcon$DateTime, houpowcon$Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l'))

##Energy Sub meter
with(houpowcon,plot(houpowcon$DateTime, houpowcon$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l'))
lines(houpowcon$DateTime, houpowcon$Sub_metering_2,col="red")
lines(houpowcon$DateTime, houpowcon$Sub_metering_3,col="blue")

##Global reactive power
with(houpowcon,plot(houpowcon$DateTime, houpowcon$Global_reactive_power, xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l'))
dev.off()

