## Set Working Directory
setwd("C:/Users/dave_/OneDrive/GitHub/Coursera/Exploratory Data Analysis/Week 1/ExData_Plotting1")

## Load the data
uci <- read.table("household_power_consumption.txt", header = TRUE, sep=";")

## Tidy the data before we plot
uci$Date <- as.Date(uci$Date, format = "%d/%m/%Y") ## Set the Date variable as date

## Coerce to numeric - this creates NA's into the mix
uci$Global_active_power <- as.numeric(levels(uci$Global_active_power))[uci$Global_active_power]
uci$Global_reactive_power <- as.numeric(levels(uci$Global_reactive_power))[uci$Global_reactive_power]

uci$Sub_metering_1 <- as.numeric(levels(uci$Sub_metering_1))[uci$Sub_metering_1]
uci$Sub_metering_2 <- as.numeric(levels(uci$Sub_metering_2))[uci$Sub_metering_2]

uci$Voltage <- as.numeric(levels(uci$Voltage))[uci$Voltage]

## Subset the data to only 2007-02-01 and 2007-02-02
uciSubs <- subset(uci, Date == "2007-02-01" | Date == "2007-02-02")

## Remove other file to clear some space in RAM
rm(uci)


## Add a new variable with date and time
uciSubs$DateTime <- as.POSIXct(paste(uciSubs$Date, uciSubs$Time), format="%Y-%m-%d %H:%M:%S")


## Create PNG device 
png("plot4.png", width = 480, height = 480, units = "px")


## Set up the chart area for 2 x 2
par(mfcol = c(2,2))


## Plot the first chart
with(uciSubs, plot(DateTime, Global_active_power,
                   type = "l",
                   ylab = "Global Active Power",
                   xlab = ""))


## Create second plot with Sub_metering
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
       col = c("black", "red","blue"), lty = c(1,1,1), bty = "n")



## Plot the third chart
with(uciSubs, plot(DateTime, Voltage,
                   type = "l",
                   ylab = "Voltage",
                   xlab = "datetime"))

## Plot the third chart
with(uciSubs, plot(DateTime, Global_reactive_power,
                   type = "l",
                   ylab = "Global_reactive_power",
                   xlab = "datetime"))



## Close the device
dev.off()
