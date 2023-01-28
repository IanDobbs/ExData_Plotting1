## Exploratory data analysis course - week 1 - project 1 - 28/01/2023

## plot4.R

## locate and download the dataset
fileurl <-  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "epc.zip")
unzip("epc.zip")

## load the dataset, household_power_consumption.txt file

epcdata <- read.table(file = "household_power_consumption.txt", # TXT data file indicated as string
           header = TRUE,    # display the header
           sep = ";",          # semi-colon is separator of the columns of the file
           dec = ".")         # Character used to separate decimals of the numbers in the file

## convert the Date character variable to Date class to subset data

epcdata$Date <- as.Date(epcdata$Date, "%d/%m/%Y")

## subset data between 2007-02-01 and 2007-02-02

epcsub <- epcdata[epcdata$Date >= "2007-02-01" & epcdata$Date <= "2007-02-02", ]

## merge date and time into new variable and convert to time class
epcsub$DateTime <- paste(epcsub$Date, epcsub$Time)
epcsub$DateTime <- strptime(epcsub$DateTime, "%Y-%m-%d %H:%M:%S")

## coerce voltage and global reactive power to numeric
epcsub$Voltage <- as.numeric(epcsub$Voltage)
epcsub$Global_reactive_power <- as.numeric(epcsub$Global_reactive_power)

png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
with(epcsub, {
        plot(DateTime, as.numeric(Global_active_power), type = "l",
             ylab = "Global Active Power (kilowatts)",
             xlab = "",
             cex.lab = 0.8,
             cex.axis = 0.8)
        lines(DateTime, as.numeric(Global_active_power), type = "l")
        
        plot(DateTime, Voltage, type = "l",
             cex.lab = 0.8,
             cex.axis = 0.8)
        lines(DateTime, Voltage, type = "l")
        
        plot(DateTime, as.numeric(Sub_metering_1), type = "l",
             ylab = "Energy sub metering",
             xlab = "",
             col = "grey",
             cex.lab = 0.8,
             cex.axis = 0.8)
        lines(DateTime, as.numeric(Sub_metering_2), type = "l", col = "red")
        lines(DateTime, as.numeric(Sub_metering_3), type = "l", col = "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
               col=c("grey", "red", "blue"),
               lty = 1,
               cex = 0.8) ## adjust the size of the legend, less than 1 reduces the size
        
        plot(DateTime, Global_reactive_power, type = "l",
             cex.lab = 0.8,
             cex.axis = 0.8)
        lines(DateTime, Global_reactive_power, type = "l")
})
dev.off(which = dev.cur())