## Exploratory data analysis course - week 1 - project 1 - 28/01/2023

## plot1.R

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

## plot 1 is a histogram of the variable Global Active Power

png("plot1.png", width = 480, height = 480, units = "px")
hist(as.numeric(epcsub$Global_active_power), 
     xlab = "Global Active Power (kilowatts)", 
     col = "red", 
     main = "Global Active Power",
     cex.lab = 0.7,
     cex.axis = 0.7)
dev.off()