readZip <- function(fname,ename,sep=",",na.strings = "NA") {
  temp <- tempfile()
  download.file(fname,temp)
  data <- read.csv(unz(temp, ename),sep=sep,na.strings=na.strings)
  unlink(temp)
  data
}

data <- subset(readZip("http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip","household_power_consumption.txt",sep=";",na.strings = "?"),Date %in% c("1/2/2007","2/2/2007"))
#data <- subset(read.csv(unz("/tmp/household_power_consumption.zip", "household_power_consumption.txt"),sep=";",na.strings = "?",nrows=-1),Date %in% c("1/2/2007","2/2/2007"))

#data$datetime <- as.POSIXlt(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
#data$Date <- NULL
#data$Time <- NULL

# boxplot(data$Global_reactive_power)

png(file="plot1.png",width = 480, height = 480)
hist(data$Global_active_power,freq=TRUE,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
