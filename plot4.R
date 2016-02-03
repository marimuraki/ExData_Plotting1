# Source: https://github.com/marimuraki/ExData_Plotting1

rm(list=ls())
setwd("/Users/marimuraki/Dropbox/Mari/courses/Coursera/Exploratory Data Analysis/ExData_Plotting1")

url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip   <- "./data/exdata-data-household_power_consumption.zip" 
file  <- "./data/household_power_consumption.txt"

if (!file.exists(zip)) {
  download.file(url, 
                destfile=zip)
}

if (!file.exists(file)) {
  unzip(zip, 
        exdir="./data")
  file.remove(zip)
}

data <- read.csv(file, 
                 sep=";",
                 na.string = "?",
                 header=TRUE)

# Only interested in dates [2007-02-01, 2007-02-02]

data$Date_num <- as.Date(data$Date, format="%d/%m/%Y")
data_subset   <- data[data$Date_num >= as.Date("2007-02-01") & data$Date_num <= as.Date("2007-02-02"),]

data_subset$DateTime <- as.POSIXct(paste(data_subset$Date, data_subset$Time, sep=" "),
                                   format="%d/%m/%Y %H:%M:%S")

# Plot of {Global Active Power, Voltage, Energy Sub Metering, Global Reactive Power} over Time

png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(data_subset$DateTime,
     data_subset$Global_active_power,
     type="l",
     col="black",
     xlab="",
     ylab="Global Active Power",
     main="")
plot(data_subset$DateTime,
     data_subset$Voltage,
     type="l",
     col="black",
     xlab="datetime",
     ylab="Voltage",
     main="")
plot(data_subset$DateTime,
     data_subset$Sub_metering_1,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering",
     main="")
lines(data_subset$DateTime,
      data_subset$Sub_metering_2,
      col="red")
lines(data_subset$DateTime,
      data_subset$Sub_metering_3,
      col="blue")
legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1,
       lwd=1)
plot(data_subset$DateTime,
     data_subset$Global_reactive_power,
     type="l",
     col="black",
     xlab="datetime",
     ylab="Global_reactive_power",
     main="")
dev.off()

