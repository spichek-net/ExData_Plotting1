readZip <- function(fname,ename,sep=",",na.strings = "NA") {
  temp <- tempfile()
  download.file(fname,temp)
  data <- read.csv(unz(temp, ename),sep=sep,na.strings=na.strings)
  unlink(temp)
  data
}

data <- subset(readZip("http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip","household_power_consumption.txt",sep=";",na.strings = "?"),Date %in% c("1/2/2007","2/2/2007"))
#data <- subset(read.csv(unz("/tmp/household_power_consumption.zip", "household_power_consumption.txt"),sep=";",na.strings = "?",nrows=-1),Date %in% c("1/2/2007","2/2/2007"))

data$datetime <- as.POSIXlt(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")

png(file="plot3.png",width = 480, height = 480)
with(data,plot(datetime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
with(data,points(datetime,Sub_metering_2,type="l",col="red"))
with(data,points(datetime,Sub_metering_3,type="l",col="blue"))
legend("topright",pch=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_3","Sub_metering_3"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_3","Sub_metering_3"))
dev.off()
