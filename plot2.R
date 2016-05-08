##downloading the data and unzipping

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f<-file.path(getwd(),"hopoco.zip")
download.file(url,f)
unzip(f,exdir = getwd())

##Reading data into R
fp=file.path(getwd(),"hopowcon.txt")
houpowcon<-read.table(text=grep("^[1,2]/2/2007",readLines(fp),value = TRUE),sep=';',col.names =c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

##Creating plot
houpowcon$Date <- as.Date(houpowcon$Date, format = 'dd/mm/YYYY')
houpowcon$DateTime <- strptime(paste(houpowcon$Date, houpowcon$Time),format = "%Y-%m-%d %H:%M:%S",tz="")
png(filename = "./plot2.png",width = 480,height = 480,units = "px")
with(houpowcon,plot(houpowcon$DateTime, houpowcon$Global_active_power, xlab = '', ylab = 'Global Active Power (kilowatt)', type = 'l'))
dev.off()

