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

# Histogram of Global Active Power

png(file="plot1.png", width=480, height=480)
hist(data_subset$Global_active_power, 
     col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()
