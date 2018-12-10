## Set Working Directory
setwd("C:/Users/dave_/OneDrive/GitHub/Coursera/Exploratory Data Analysis/Week 1/ExData_Plotting1")

## Load the data
uci <- read.table("household_power_consumption.txt", header = TRUE, sep=";")

## Tidy the data before we plot
uci$Date <- as.Date(uci$Date, format = "%d/%m/%Y") ## Set the Date variable as date

## Coerce to numeric - this creates NA's into the mix
uci$Sub_metering_1 <- as.numeric(levels(uci$Sub_metering_1))[uci$Sub_metering_1]
uci$Sub_metering_2 <- as.numeric(levels(uci$Sub_metering_2))[uci$Sub_metering_2]

## Subset the data to only 2007-02-01 and 2007-02-02
uciSubs <- subset(uci, Date == "2007-02-01" | Date == "2007-02-02")

## Remove other file to clear some space in RAM
rm(uci)


## Add a new variable with date and time
uciSubs$DateTime <- as.POSIXct(paste(uciSubs$Date, uciSubs$Time), format="%Y-%m-%d %H:%M:%S")


## Create PNG device 
png("plot3.png", width = 480, height = 480, units = "px")


## Create initial plot with Sub_metering_1
with(uciSubs, plot(DateTime, Sub_metering_1,
                   type = "l",
                   ylab = "Energy sub metering",
                   xlab = ""))

## Add next series with points for Sub metering 2
lines(uciSubs$DateTime, uciSubs$Sub_metering_2, type = "l", col = "red")

## Add next series with points for Sub metering 3
lines(uciSubs$DateTime, uciSubs$Sub_metering_3, type = "l", col = "blue")

##Add a legend top right corner
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black", "red","blue"), lty = c(1,1,1))


## Close the device
dev.off()
