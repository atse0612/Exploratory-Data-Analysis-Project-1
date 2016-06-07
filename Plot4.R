## Plot 4 of 4
## Exploratory Data Analysis
## Data Set for Individual Household Electric Power Consumption



dataDirectory<-"household_power_consumption.txt"

if (!file.exists(dataDirectory)) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  tempfile <- "./tempData.zip"
  download.file(url,tempfile)
  unzip(tempfile)
  unlink(tempfile)
}

# Read and Unzip Table

powerData <- read.table("./household_power_consumption.txt", stringsAsFactors = F ,header =TRUE, sep =';')

date <- paste(powerData$Date, powerData$Time)
date <- strptime(date, "%d/%m/%Y %H:%M:%S")
powerData$Date = date

selectDataRange <- powerData[as.Date(date) >= as.Date("2007-02-01") & as.Date(date) <= as.Date("2007-02-02"),]
selectDataRange$Global_active_power <- as.numeric(selectDataRange$Global_active_power)

# Retrieving and Save Plot to PNG File

png(filename = "plot4.png",width = 480, height = 480)

# Combining all 4 plots into one file

par(mfrow = c(2,2))

plot(selectDataRange$Date, selectDataRange$Global_active_power,xlab = "", ylab = "Gloabal Active Power(kilowatts)",type = "l")

plot(selectDataRange$Date, selectDataRange$Voltage,xlab = "datetime", ylab = "Voltage",type = "l")

plot(selectDataRange$Date, selectDataRange$Sub_metering_1,xlab = "", ylab = "Energy sub metering",type = "l")
lines(selectDataRange$Date, selectDataRange$Sub_metering_2, col = "red")
lines(selectDataRange$Date, selectDataRange$Sub_metering_3, col = "blue")
legend("topright","group",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=c(1,1),col=c("black" ,"blue","red"))

plot(selectDataRange$Date, selectDataRange$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power",type = "l")

dev.off()
