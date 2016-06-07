## Plot 2 of 4
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

# Read Table
powerData <- read.table("./household_power_consumption.txt", stringsAsFactors = F ,header =TRUE, sep =';')

date <- paste(powerData$Date, powerData$Time)
date <- strptime(date, "%d/%m/%Y %H:%M:%S")
powerData$Date = date

# Get Data 
selectDataRange <- powerData[as.Date(date) >= as.Date("2007-02-01") & as.Date(date) <= as.Date("2007-02-02"),]
selectDataRange$Global_active_power <- as.numeric(selectDataRange$Global_active_power)

# Retrieving and Save Plot to PNG File
png(filename = "plot2.png",width = 480, height = 480)

plot(selectDataRange$Date, selectDataRange$Global_active_power,xlab = "", ylab = "Gloabal Active Power(kilowatts)",type = "l")

dev.off()
