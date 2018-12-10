## Set Working Directory
setwd("C:/Users/dave_/OneDrive/GitHub/Coursera/Exploratory Data Analysis/Week 1/ExData_Plotting1")

## Load the data
uci <- read.table("household_power_consumption.txt", header = TRUE, sep=";")

## Tidy the data before we plot
uci$Date <- as.Date(uci$Date, format = "%d/%m/%Y") ## Set the Date variable as date


## Coerce to numeric - this creates NA's into the mix
uci$Global_active_power <- as.numeric(levels(uci$Global_active_power))[uci$Global_active_power]

## Subset the data to only 2007-02-01 and 2007-02-02
uciSubs <- subset(uci, Date == "2007-02-01" | Date == "2007-02-02")

## Remove other file to clear some space in RAM
rm(uci)


## Add a new variable with date and time
uciSubs$DateTime <- as.POSIXct(paste(uciSubs$Date, uciSubs$Time), format="%Y-%m-%d %H:%M:%S")

## Create PNG device 
png("plot2.png", width = 480, height = 480, units = "px")

## Plot the chart
with(uciSubs, plot(DateTime, Global_active_power,
                   type = "l",
                   ylab = "Global Active Power (kilowatts)",
                   xlab = ""))

## Close the PNG device
dev.off()