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

## Create the PNG
png("plot1.png", width = 480, height = 480, units = "px")

## Plot the initial chart
with(uciSubs, hist(Global_active_power, col = "red", 
                           main = "Global Active Power",
                   xlab = "Global Active Power (kilowatts)"))

## Close the PNG device
dev.off()
